#using scripts/shared/ai/archetype_utility;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/ai_shared;

#namespace phalanx;

// Namespace phalanx
// Method(s) 25 Total 25
class phalanx {

    // Namespace phalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0x6e402192, Offset: 0x18c8
    // Size: 0x40
    function constructor() {
        self.sentienttiers_ = [];
        self.startsentientcount_ = 0;
        self.currentsentientcount_ = 0;
        self.breakingpoint_ = 0;
        self.scattered_ = 0;
    }

    // Namespace phalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0xdee1a0f, Offset: 0x2160
    // Size: 0x15a
    function scatterphalanx() {
        if (!self.scattered_) {
            self.scattered_ = 1;
            _releasesentients(self.sentienttiers_["phalanx_tier1"]);
            self.sentienttiers_["phalanx_tier1"] = [];
            _assignphalanxstance(self.sentienttiers_["phalanx_tier2"], "crouch");
            wait(randomfloatrange(5, 7));
            _releasesentients(self.sentienttiers_["phalanx_tier2"]);
            self.sentienttiers_["phalanx_tier2"] = [];
            _assignphalanxstance(self.sentienttiers_["phalanx_tier3"], "crouch");
            wait(randomfloatrange(5, 7));
            _releasesentients(self.sentienttiers_["phalanx_tier3"]);
            self.sentienttiers_["phalanx_tier3"] = [];
        }
    }

    // Namespace phalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2de4ae11, Offset: 0x20d8
    // Size: 0x7c
    function resumefire() {
        _resumefiresentients(self.sentienttiers_["phalanx_tier1"]);
        _resumefiresentients(self.sentienttiers_["phalanx_tier2"]);
        _resumefiresentients(self.sentienttiers_["phalanx_tier3"]);
    }

    // Namespace phalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0x49df480a, Offset: 0x1f68
    // Size: 0x164
    function resumeadvance() {
        if (!self.scattered_) {
            _assignphalanxstance(self.sentienttiers_["phalanx_tier1"], "stand");
            wait(1);
            forward = vectornormalize(self.endposition_ - self.startposition_);
            _movephalanxtier(self.sentienttiers_["phalanx_tier1"], self.phalanxtype_, "phalanx_tier1", self.endposition_, forward);
            _movephalanxtier(self.sentienttiers_["phalanx_tier2"], self.phalanxtype_, "phalanx_tier2", self.endposition_, forward);
            _movephalanxtier(self.sentienttiers_["phalanx_tier3"], self.phalanxtype_, "phalanx_tier3", self.endposition_, forward);
            _assignphalanxstance(self.sentienttiers_["phalanx_tier1"], "crouch");
        }
    }

    // Namespace phalanx
    // Params 8, eflags: 0x1 linked
    // Checksum 0xce283740, Offset: 0x1b78
    // Size: 0x3e4
    function initialize(phalanxtype, origin, destination, breakingpoint, maxtiersize, tieronespawner, tiertwospawner, tierthreespawner) {
        if (!isdefined(maxtiersize)) {
            maxtiersize = 10;
        }
        if (!isdefined(tieronespawner)) {
            tieronespawner = undefined;
        }
        if (!isdefined(tiertwospawner)) {
            tiertwospawner = undefined;
        }
        if (!isdefined(tierthreespawner)) {
            tierthreespawner = undefined;
        }
        /#
            assert(isstring(phalanxtype));
        #/
        /#
            assert(isint(breakingpoint));
        #/
        /#
            assert(isvec(origin));
        #/
        /#
            assert(isvec(destination));
        #/
        tierspawners = [];
        tierspawners["phalanx_tier1"] = tieronespawner;
        tierspawners["phalanx_tier2"] = tiertwospawner;
        tierspawners["phalanx_tier3"] = tierthreespawner;
        maxtiersize = math::clamp(maxtiersize, 1, 10);
        forward = vectornormalize(destination - origin);
        foreach (tiername in array("phalanx_tier1", "phalanx_tier2", "phalanx_tier3")) {
            self.sentienttiers_[tiername] = _createphalanxtier(phalanxtype, tiername, origin, forward, maxtiersize, tierspawners[tiername]);
            self.startsentientcount_ += self.sentienttiers_[tiername].size;
        }
        _assignphalanxstance(self.sentienttiers_["phalanx_tier1"], "crouch");
        foreach (name, tier in self.sentienttiers_) {
            _movephalanxtier(self.sentienttiers_[name], phalanxtype, name, destination, forward);
        }
        self.breakingpoint_ = breakingpoint;
        self.startposition_ = origin;
        self.endposition_ = destination;
        self.phalanxtype_ = phalanxtype;
        self thread _updatephalanxthread(self);
    }

    // Namespace phalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0xff39d917, Offset: 0x1ad0
    // Size: 0x9a
    function haltadvance() {
        if (!self.scattered_) {
            foreach (tier in self.sentienttiers_) {
                _haltadvance(tier);
            }
        }
    }

    // Namespace phalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0x3ec579a5, Offset: 0x1a38
    // Size: 0x8a
    function haltfire() {
        foreach (tier in self.sentienttiers_) {
            _haltfire(tier);
        }
    }

    // Namespace phalanx
    // Params 0, eflags: 0x5 linked
    // Checksum 0x951d7949, Offset: 0x1920
    // Size: 0x10c
    function _updatephalanx() {
        if (self.scattered_) {
            return false;
        }
        self.currentsentientcount_ = 0;
        foreach (name, tier in self.sentienttiers_) {
            self.sentienttiers_[name] = _prunedead(tier);
            self.currentsentientcount_ += self.sentienttiers_[name].size;
        }
        if (self.currentsentientcount_ <= self.startsentientcount_ - self.breakingpoint_) {
            scatterphalanx();
            return false;
        }
        return true;
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xc2391823, Offset: 0x1898
    // Size: 0x28
    function _updatephalanxthread(phalanx) {
        while ([[ phalanx ]]->_updatephalanx()) {
            wait(1);
        }
    }

    // Namespace phalanx
    // Params 2, eflags: 0x5 linked
    // Checksum 0xffdd27cc, Offset: 0x17f0
    // Size: 0xa0
    function _rotatevec(vector, angle) {
        return (vector[0] * cos(angle) - vector[1] * sin(angle), vector[0] * sin(angle) + vector[1] * cos(angle), vector[2]);
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xc5bf8d1f, Offset: 0x1720
    // Size: 0xc2
    function _resumefiresentients(sentients) {
        /#
            assert(isarray(sentients));
        #/
        foreach (sentient in sentients) {
            _resumefire(sentient);
        }
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x63c49bd1, Offset: 0x16d8
    // Size: 0x40
    function _resumefire(sentient) {
        if (isdefined(sentient) && isalive(sentient)) {
            sentient.ignoreall = 0;
        }
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x4aa02edf, Offset: 0x1600
    // Size: 0xca
    function _releasesentients(sentients) {
        foreach (sentient in sentients) {
            _resumefire(sentient);
            _releasesentient(sentient);
            wait(randomfloatrange(0.5, 5));
        }
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x62eb1995, Offset: 0x1460
    // Size: 0x194
    function _releasesentient(sentient) {
        if (isdefined(sentient) && isalive(sentient)) {
            sentient clearuseposition();
            sentient pathmode("move delayed", 1, randomfloatrange(0.5, 1));
            sentient ai::set_behavior_attribute("phalanx", 0);
            wait(0.05);
            if (sentient.archetype === "human") {
                sentient.allowpain = 1;
            }
            sentient setavoidancemask("avoid all");
            aiutility::removeaioverridedamagecallback(sentient, &_dampenexplosivedamage);
            if (isdefined(sentient.archetype) && sentient.archetype == "robot") {
                sentient ai::set_behavior_attribute("move_mode", "normal");
                sentient ai::set_behavior_attribute("force_cover", 0);
            }
        }
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x3c13c3a6, Offset: 0x1398
    // Size: 0xc0
    function _prunedead(sentients) {
        livesentients = [];
        foreach (index, sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                livesentients[index] = sentient;
            }
        }
        return livesentients;
    }

    // Namespace phalanx
    // Params 5, eflags: 0x5 linked
    // Checksum 0x9403f38e, Offset: 0x1178
    // Size: 0x212
    function _movephalanxtier(sentients, phalanxtype, tier, destination, forward) {
        positions = _getphalanxpositions(phalanxtype, tier);
        angles = vectortoangles(forward);
        /#
            assert(sentients.size <= positions.size, "phalanx_tier2");
        #/
        foreach (index, sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                /#
                    assert(isvec(positions[index]), "phalanx_tier2" + index + "phalanx_tier2" + tier + "phalanx_tier2" + phalanxtype);
                #/
                orientedpos = _rotatevec(positions[index], angles[1] - 90);
                navmeshposition = getclosestpointonnavmesh(destination + orientedpos, -56);
                sentient useposition(navmeshposition);
            }
        }
    }

    // Namespace phalanx
    // Params 1, eflags: 0x1 linked
    // Checksum 0x1cc79723, Offset: 0x1028
    // Size: 0x144
    function _initializesentient(sentient) {
        /#
            assert(isactor(sentient));
        #/
        sentient ai::set_behavior_attribute("phalanx", 1);
        if (sentient.archetype === "human") {
            sentient.allowpain = 0;
        }
        sentient setavoidancemask("avoid none");
        if (isdefined(sentient.archetype) && sentient.archetype == "robot") {
            sentient ai::set_behavior_attribute("move_mode", "marching");
            sentient ai::set_behavior_attribute("force_cover", 1);
        }
        aiutility::addaioverridedamagecallback(sentient, &_dampenexplosivedamage, 1);
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xf92052a6, Offset: 0xf40
    // Size: 0xde
    function _haltfire(sentients) {
        /#
            assert(isarray(sentients));
        #/
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                sentient.ignoreall = 1;
            }
        }
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xa30a51ac, Offset: 0xde8
    // Size: 0x14a
    function _haltadvance(sentients) {
        /#
            assert(isarray(sentients));
        #/
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient) && sentient haspath()) {
                navmeshposition = getclosestpointonnavmesh(sentient.origin, -56);
                sentient useposition(navmeshposition);
                sentient clearpath();
            }
        }
    }

    // Namespace phalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xf7443407, Offset: 0xd20
    // Size: 0xbc
    function _getphalanxspawner(tier) {
        spawner = getspawnerarray(tier, "targetname");
        /#
            assert(spawner.size >= 0, "phalanx_tier2" + "phalanx_tier2" + "phalanx_tier2");
        #/
        /#
            assert(spawner.size == 1, "phalanx_tier2" + "phalanx_tier2" + "phalanx_tier2");
        #/
        return spawner[0];
    }

    // Namespace phalanx
    // Params 2, eflags: 0x5 linked
    // Checksum 0x137c7964, Offset: 0x7a0
    // Size: 0x574
    function _getphalanxpositions(phalanxtype, tier) {
        switch (phalanxtype) {
        case 16:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (-64, -48, 0), (64, -48, 0), (-128, -96, 0), (-128, -96, 0));
            case 8:
                return array((-32, -96, 0), (32, -96, 0));
            case 9:
                return array();
            }
            goto LOC_00000150;
        case 15:
            switch (tier) {
            case 7:
                return array((-32, 0, 0), (32, 0, 0));
            case 8:
                return array((0, -96, 0));
            case 9:
                return array();
            }
        LOC_00000150:
            goto LOC_00000210;
        case 12:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (-48, -64, 0), (-96, -128, 0), (-144, -192, 0));
            case 8:
                return array((64, 0, 0), (16, -64, 0), (-48, -128, 0), (-112, -192, 0));
            case 9:
                return array();
            }
        LOC_00000210:
            goto LOC_000002d0;
        case 13:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (48, -64, 0), (96, -128, 0), (-112, -192, 0));
            case 8:
                return array((-64, 0, 0), (-16, -64, 0), (48, -128, 0), (112, -192, 0));
            case 9:
                return array();
            }
        LOC_000002d0:
            goto LOC_00000388;
        case 14:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (64, 0, 0), (128, 0, 0), (192, 0, 0));
            case 8:
                return array((-32, -64, 0), (32, -64, 0), (96, -64, 0), (-96, -64, 0));
            case 9:
                return array();
            }
        LOC_00000388:
            goto LOC_00000448;
        case 10:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (-64, 0, 0), (0, -64, 0), (-64, -64, 0));
            case 8:
                return array((0, -128, 0), (-64, -128, 0), (0, -192, 0), (-64, -192, 0));
            case 9:
                return array();
            }
        LOC_00000448:
            goto LOC_000004d0;
        case 11:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (0, -64, 0), (0, -128, 0), (0, -192, 0));
            case 8:
                return array();
            case 9:
                return array();
            }
        LOC_000004d0:
            break;
        default:
            /#
                assert("phalanx_tier2" + phalanxtype + "phalanx_tier2");
            #/
            break;
        }
        /#
            assert("phalanx_tier2" + tier + "phalanx_tier2");
        #/
    }

    // Namespace phalanx
    // Params c, eflags: 0x5 linked
    // Checksum 0x2f4a405b, Offset: 0x5d0
    // Size: 0x1c8
    function _dampenexplosivedamage(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
        entity = self;
        isexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdamage);
        if (isexplosive && isdefined(inflictor) && isdefined(inflictor.weapon)) {
            weapon = inflictor.weapon;
            distancetoentity = distance(entity.origin, inflictor.origin);
            fractiondistance = 1;
            if (weapon.explosionradius > 0) {
                fractiondistance = (weapon.explosionradius - distancetoentity) / weapon.explosionradius;
            }
            return int(max(damage * fractiondistance, 1));
        }
        return damage;
    }

    // Namespace phalanx
    // Params 6, eflags: 0x5 linked
    // Checksum 0x4ff4c826, Offset: 0x380
    // Size: 0x248
    function _createphalanxtier(phalanxtype, tier, phalanxposition, forward, maxtiersize, spawner) {
        if (!isdefined(spawner)) {
            spawner = undefined;
        }
        sentients = [];
        if (!isspawner(spawner)) {
            spawner = _getphalanxspawner(tier);
        }
        positions = _getphalanxpositions(phalanxtype, tier);
        angles = vectortoangles(forward);
        foreach (index, position in positions) {
            if (index >= maxtiersize) {
                break;
            }
            orientedpos = _rotatevec(position, angles[1] - 90);
            navmeshposition = getclosestpointonnavmesh(phalanxposition + orientedpos, -56);
            if (!(spawner.spawnflags & 64)) {
                spawner.count++;
            }
            sentient = spawner spawner::spawn(1, "", navmeshposition, angles);
            _initializesentient(sentient);
            wait(0.05);
            sentients[sentients.size] = sentient;
        }
        return sentients;
    }

    // Namespace phalanx
    // Params 2, eflags: 0x5 linked
    // Checksum 0xb2aef026, Offset: 0x280
    // Size: 0xf2
    function _assignphalanxstance(sentients, stance) {
        /#
            assert(isarray(sentients));
        #/
        foreach (sentient in sentients) {
            if (isdefined(sentient) && isalive(sentient)) {
                sentient ai::set_behavior_attribute("phalanx_force_stance", stance);
            }
        }
    }

}


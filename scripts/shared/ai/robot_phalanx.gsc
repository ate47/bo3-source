#using scripts/shared/ai/archetype_utility;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/ai_shared;

#namespace robotphalanx;

// Namespace robotphalanx
// Method(s) 25 Total 25
class robotphalanx {

    // Namespace robotphalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0x739fba53, Offset: 0x1780
    // Size: 0x58
    function constructor() {
        self.tier1robots_ = [];
        self.tier2robots_ = [];
        self.tier3robots_ = [];
        self.startrobotcount_ = 0;
        self.currentrobotcount_ = 0;
        self.breakingpoint_ = 0;
        self.scattered_ = 0;
    }

    // Namespace robotphalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2ff433d6, Offset: 0x1e78
    // Size: 0x100
    function scatterphalanx() {
        if (!self.scattered_) {
            self.scattered_ = 1;
            _releaserobots(self.tier1robots_);
            self.tier1robots_ = [];
            _assignphalanxstance(self.tier2robots_, "crouch");
            wait(randomfloatrange(5, 7));
            _releaserobots(self.tier2robots_);
            self.tier2robots_ = [];
            _assignphalanxstance(self.tier3robots_, "crouch");
            wait(randomfloatrange(5, 7));
            _releaserobots(self.tier3robots_);
            self.tier3robots_ = [];
        }
    }

    // Namespace robotphalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0xac88a1f4, Offset: 0x1e20
    // Size: 0x4c
    function resumefire() {
        _resumefirerobots(self.tier1robots_);
        _resumefirerobots(self.tier2robots_);
        _resumefirerobots(self.tier3robots_);
    }

    // Namespace robotphalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0xde707302, Offset: 0x1cf0
    // Size: 0x124
    function resumeadvance() {
        if (!self.scattered_) {
            _assignphalanxstance(self.tier1robots_, "stand");
            wait(1);
            forward = vectornormalize(self.endposition_ - self.startposition_);
            _movephalanxtier(self.tier1robots_, self.phalanxtype_, "phalanx_tier1", self.endposition_, forward);
            _movephalanxtier(self.tier2robots_, self.phalanxtype_, "phalanx_tier2", self.endposition_, forward);
            _movephalanxtier(self.tier3robots_, self.phalanxtype_, "phalanx_tier3", self.endposition_, forward);
            _assignphalanxstance(self.tier1robots_, "crouch");
        }
    }

    // Namespace robotphalanx
    // Params 8, eflags: 0x1 linked
    // Checksum 0x24b3de30, Offset: 0x1988
    // Size: 0x35c
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
        maxtiersize = math::clamp(maxtiersize, 1, 10);
        forward = vectornormalize(destination - origin);
        self.tier1robots_ = _createphalanxtier(phalanxtype, "phalanx_tier1", origin, forward, maxtiersize, tieronespawner);
        self.tier2robots_ = _createphalanxtier(phalanxtype, "phalanx_tier2", origin, forward, maxtiersize, tiertwospawner);
        self.tier3robots_ = _createphalanxtier(phalanxtype, "phalanx_tier3", origin, forward, maxtiersize, tierthreespawner);
        _assignphalanxstance(self.tier1robots_, "crouch");
        _movephalanxtier(self.tier1robots_, phalanxtype, "phalanx_tier1", destination, forward);
        _movephalanxtier(self.tier2robots_, phalanxtype, "phalanx_tier2", destination, forward);
        _movephalanxtier(self.tier3robots_, phalanxtype, "phalanx_tier3", destination, forward);
        self.startrobotcount_ = self.tier1robots_.size + self.tier2robots_.size + self.tier3robots_.size;
        self.breakingpoint_ = breakingpoint;
        self.startposition_ = origin;
        self.endposition_ = destination;
        self.phalanxtype_ = phalanxtype;
        self thread _updatephalanxthread(self);
    }

    // Namespace robotphalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa42156b8, Offset: 0x1928
    // Size: 0x54
    function haltadvance() {
        if (!self.scattered_) {
            _haltadvance(self.tier1robots_);
            _haltadvance(self.tier2robots_);
            _haltadvance(self.tier3robots_);
        }
    }

    // Namespace robotphalanx
    // Params 0, eflags: 0x1 linked
    // Checksum 0x4550017c, Offset: 0x18d0
    // Size: 0x4c
    function haltfire() {
        _haltfire(self.tier1robots_);
        _haltfire(self.tier2robots_);
        _haltfire(self.tier3robots_);
    }

    // Namespace robotphalanx
    // Params 0, eflags: 0x5 linked
    // Checksum 0x2472769d, Offset: 0x17f0
    // Size: 0xd4
    function _updatephalanx() {
        if (self.scattered_) {
            return false;
        }
        self.tier1robots_ = _prunedead(self.tier1robots_);
        self.tier2robots_ = _prunedead(self.tier2robots_);
        self.tier3robots_ = _prunedead(self.tier3robots_);
        self.currentrobotcount_ = self.tier1robots_.size + self.tier2robots_.size + self.tier2robots_.size;
        if (self.currentrobotcount_ <= self.startrobotcount_ - self.breakingpoint_) {
            scatterphalanx();
            return false;
        }
        return true;
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xf304cce7, Offset: 0x1750
    // Size: 0x28
    function _updatephalanxthread(phalanx) {
        while ([[ phalanx ]]->_updatephalanx()) {
            wait(1);
        }
    }

    // Namespace robotphalanx
    // Params 2, eflags: 0x5 linked
    // Checksum 0xbd4b7a70, Offset: 0x16a8
    // Size: 0xa0
    function _rotatevec(vector, angle) {
        return (vector[0] * cos(angle) - vector[1] * sin(angle), vector[0] * sin(angle) + vector[1] * cos(angle), vector[2]);
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xd481a9fd, Offset: 0x15d8
    // Size: 0xc2
    function _resumefirerobots(robots) {
        /#
            assert(isarray(robots));
        #/
        foreach (robot in robots) {
            _resumefire(robot);
        }
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x36f8d4d8, Offset: 0x1590
    // Size: 0x40
    function _resumefire(robot) {
        if (isdefined(robot) && isalive(robot)) {
            robot.ignoreall = 0;
        }
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x110463ec, Offset: 0x14b8
    // Size: 0xca
    function _releaserobots(robots) {
        foreach (robot in robots) {
            _resumefire(robot);
            _releaserobot(robot);
            wait(randomfloatrange(0.5, 5));
        }
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x92772e2b, Offset: 0x1378
    // Size: 0x134
    function _releaserobot(robot) {
        if (isdefined(robot) && isalive(robot)) {
            robot clearuseposition();
            robot pathmode("move delayed", 1, randomfloatrange(0.5, 1));
            robot ai::set_behavior_attribute("phalanx", 0);
            wait(0.05);
            robot ai::set_behavior_attribute("move_mode", "normal");
            robot ai::set_behavior_attribute("force_cover", 0);
            robot setavoidancemask("avoid all");
            aiutility::removeaioverridedamagecallback(robot, &_dampenexplosivedamage);
        }
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x75c7ff0d, Offset: 0x12b0
    // Size: 0xc0
    function _prunedead(robots) {
        liverobots = [];
        foreach (index, robot in robots) {
            if (isdefined(robot) && isalive(robot)) {
                liverobots[index] = robot;
            }
        }
        return liverobots;
    }

    // Namespace robotphalanx
    // Params 5, eflags: 0x5 linked
    // Checksum 0x83d68cfc, Offset: 0x1090
    // Size: 0x212
    function _movephalanxtier(robots, phalanxtype, tier, destination, forward) {
        positions = _getphalanxpositions(phalanxtype, tier);
        angles = vectortoangles(forward);
        /#
            assert(robots.size <= positions.size, "phalanx_tier2");
        #/
        foreach (index, robot in robots) {
            if (isdefined(robot) && isalive(robot)) {
                /#
                    assert(isvec(positions[index]), "phalanx_tier2" + index + "phalanx_tier2" + tier + "phalanx_tier2" + phalanxtype);
                #/
                orientedpos = _rotatevec(positions[index], angles[1] - 90);
                navmeshposition = getclosestpointonnavmesh(destination + orientedpos, -56);
                robot useposition(navmeshposition);
            }
        }
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xc90cd839, Offset: 0xf98
    // Size: 0xec
    function _initializerobot(robot) {
        /#
            assert(isactor(robot));
        #/
        robot ai::set_behavior_attribute("phalanx", 1);
        robot ai::set_behavior_attribute("move_mode", "marching");
        robot ai::set_behavior_attribute("force_cover", 1);
        robot setavoidancemask("avoid none");
        aiutility::addaioverridedamagecallback(robot, &_dampenexplosivedamage, 1);
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x48fff1e8, Offset: 0xeb0
    // Size: 0xde
    function _haltfire(robots) {
        /#
            assert(isarray(robots));
        #/
        foreach (robot in robots) {
            if (isdefined(robot) && isalive(robot)) {
                robot.ignoreall = 1;
            }
        }
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0xe88ac232, Offset: 0xd58
    // Size: 0x14a
    function _haltadvance(robots) {
        /#
            assert(isarray(robots));
        #/
        foreach (robot in robots) {
            if (isdefined(robot) && isalive(robot) && robot haspath()) {
                navmeshposition = getclosestpointonnavmesh(robot.origin, -56);
                robot useposition(navmeshposition);
                robot clearpath();
            }
        }
    }

    // Namespace robotphalanx
    // Params 1, eflags: 0x5 linked
    // Checksum 0x9657d2f5, Offset: 0xc90
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

    // Namespace robotphalanx
    // Params 2, eflags: 0x5 linked
    // Checksum 0x37e389c4, Offset: 0x7a0
    // Size: 0x4e4
    function _getphalanxpositions(phalanxtype, tier) {
        switch (phalanxtype) {
        case 15:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (-64, -48, 0), (64, -48, 0), (-128, -96, 0), (-128, -96, 0));
            case 8:
                return array((-32, -96, 0), (32, -96, 0));
            case 9:
                return array();
            }
            goto LOC_00000188;
        case 12:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (-48, -64, 0), (-96, -128, 0), (-144, -192, 0));
            case 8:
                return array((64, 0, 0), (16, -64, 0), (-48, -128, 0), (-112, -192, 0));
            case 9:
                return array();
            }
        LOC_00000188:
            goto LOC_00000248;
        case 13:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (48, -64, 0), (96, -128, 0), (-112, -192, 0));
            case 8:
                return array((-64, 0, 0), (-16, -64, 0), (48, -128, 0), (112, -192, 0));
            case 9:
                return array();
            }
        LOC_00000248:
            goto LOC_00000300;
        case 14:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (64, 0, 0), (128, 0, 0), (192, 0, 0));
            case 8:
                return array((-32, -64, 0), (32, -64, 0), (96, -64, 0), (-96, -64, 0));
            case 9:
                return array();
            }
        LOC_00000300:
            goto LOC_000003c0;
        case 10:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (-64, 0, 0), (0, -64, 0), (-64, -64, 0));
            case 8:
                return array((0, -128, 0), (-64, -128, 0), (0, -192, 0), (-64, -192, 0));
            case 9:
                return array();
            }
        LOC_000003c0:
            goto LOC_00000448;
        case 11:
            switch (tier) {
            case 7:
                return array((0, 0, 0), (0, -64, 0), (0, -128, 0), (0, -192, 0));
            case 8:
                return array();
            case 9:
                return array();
            }
        LOC_00000448:
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

    // Namespace robotphalanx
    // Params c, eflags: 0x5 linked
    // Checksum 0x6f1e95cb, Offset: 0x5d0
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

    // Namespace robotphalanx
    // Params 6, eflags: 0x5 linked
    // Checksum 0xfabdf871, Offset: 0x368
    // Size: 0x260
    function _createphalanxtier(phalanxtype, tier, phalanxposition, forward, maxtiersize, spawner) {
        if (!isdefined(spawner)) {
            spawner = undefined;
        }
        robots = [];
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
            robot = spawner spawner::spawn(1, "", navmeshposition, angles);
            if (isalive(robot)) {
                _initializerobot(robot);
                wait(0.05);
                robots[robots.size] = robot;
            }
        }
        return robots;
    }

    // Namespace robotphalanx
    // Params 2, eflags: 0x5 linked
    // Checksum 0xd2c9fd3b, Offset: 0x268
    // Size: 0xf2
    function _assignphalanxstance(robots, stance) {
        /#
            assert(isarray(robots));
        #/
        foreach (robot in robots) {
            if (isdefined(robot) && isalive(robot)) {
                robot ai::set_behavior_attribute("phalanx_force_stance", stance);
            }
        }
    }

}


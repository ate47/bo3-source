#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/blackboard;

#namespace blackboard;

// Namespace blackboard
// Params 0, eflags: 0x1 linked
// namespace_96515e2a<file_0>::function_4a9398ae
// Checksum 0x50764af7, Offset: 0x108
// Size: 0xf4
function registervehicleblackboardattributes() {
    assert(isvehicle(self), "<unknown string>");
    registerblackboardattribute(self, "_speed", undefined, &bb_getspeed);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<unknown string>");
        #/
    }
    registerblackboardattribute(self, "_enemy_yaw", undefined, &bb_vehgetenemyyaw);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<unknown string>");
        #/
    }
}

// Namespace blackboard
// Params 0, eflags: 0x1 linked
// namespace_96515e2a<file_0>::function_ccce3b25
// Checksum 0xc5014c38, Offset: 0x208
// Size: 0x3a
function bb_getspeed() {
    velocity = self getvelocity();
    return length(velocity);
}

// Namespace blackboard
// Params 0, eflags: 0x1 linked
// namespace_96515e2a<file_0>::function_d3f5783e
// Checksum 0x6adacb43, Offset: 0x250
// Size: 0x54
function bb_vehgetenemyyaw() {
    enemy = self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = vehgetpredictedyawtoenemy(self, 0.2);
    return toenemyyaw;
}

// Namespace blackboard
// Params 2, eflags: 0x1 linked
// namespace_96515e2a<file_0>::function_466d8720
// Checksum 0x935ed51a, Offset: 0x2b0
// Size: 0x190
function vehgetpredictedyawtoenemy(entity, lookaheadtime) {
    if (isdefined(entity.predictedyawtoenemy) && isdefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
        return entity.predictedyawtoenemy;
    }
    selfpredictedpos = entity.origin;
    moveangle = entity.angles[1] + entity getmotionangle();
    selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * lookaheadtime;
    yaw = vectortoangles(entity.enemy.origin - selfpredictedpos)[1] - entity.angles[1];
    yaw = absangleclamp360(yaw);
    entity.predictedyawtoenemy = yaw;
    entity.predictedyawtoenemytime = gettime();
    return yaw;
}


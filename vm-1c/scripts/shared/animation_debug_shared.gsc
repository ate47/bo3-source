#using scripts/shared/util_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/animation_shared;

#namespace animation;

/#

    // Namespace animation
    // Params 0, eflags: 0x2
    // namespace_1fb6a2e5<file_0>::function_8c87d8eb
    // Checksum 0x49208920, Offset: 0xe0
    // Size: 0xd0
    function autoexec __init__() {
        setdvar("<unknown string>", 0);
        setdvar("<unknown string>", 0);
        while (true) {
            anim_debug = getdvarint("<unknown string>", 0) || getdvarint("<unknown string>", 0);
            level flagsys::set_val("<unknown string>", anim_debug);
            if (!anim_debug) {
                level notify(#"kill_anim_debug");
            }
            wait(0.05);
        }
    }

    // Namespace animation
    // Params 7, eflags: 0x1 linked
    // namespace_1fb6a2e5<file_0>::function_b7573cab
    // Checksum 0xa1bfacd9, Offset: 0x1b8
    // Size: 0x6e8
    function anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag, n_rate, n_blend_in, n_blend_out, n_lerp) {
        self endon(#"death");
        self endon(#"scriptedanim");
        self notify(#"_anim_info_render_thread_");
        self endon(#"_anim_info_render_thread_");
        if (!isvec(v_origin_or_ent)) {
            v_origin_or_ent endon(#"death");
        }
        recordent(self);
        while (true) {
            level flagsys::wait_till("<unknown string>");
            var_109b63b9 = 1;
            _init_frame();
            str_extra_info = "<unknown string>";
            color = (1, 1, 0);
            if (flagsys::get("<unknown string>")) {
                str_extra_info += "<unknown string>";
            }
            s_pos = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
            self anim_origin_render(s_pos.origin, s_pos.angles, undefined, undefined, !var_109b63b9);
            if (var_109b63b9) {
                line(self.origin, s_pos.origin, color, 0.5, 1);
                sphere(s_pos.origin, 2, (0.3, 0.3, 0.3), 0.5, 1);
            }
            recordline(self.origin, s_pos.origin, color, "<unknown string>");
            recordsphere(s_pos.origin, 2, (0.3, 0.3, 0.3), "<unknown string>");
            if (v_origin_or_ent != self && !isvec(v_origin_or_ent) && v_origin_or_ent != level) {
                str_name = "<unknown string>";
                if (isdefined(v_origin_or_ent.animname)) {
                    str_name = v_origin_or_ent.animname;
                } else if (isdefined(v_origin_or_ent.targetname)) {
                    str_name = v_origin_or_ent.targetname;
                }
                if (var_109b63b9) {
                    print3d(v_origin_or_ent.origin + (0, 0, 5), str_name, (0.3, 0.3, 0.3), 1, 0.15);
                }
                record3dtext(str_name, v_origin_or_ent.origin + (0, 0, 5), (0.3, 0.3, 0.3), "<unknown string>");
            }
            self anim_origin_render(self.origin, self.angles, undefined, undefined, !var_109b63b9);
            str_name = "<unknown string>";
            if (isdefined(self.anim_debug_name)) {
                str_name = self.anim_debug_name;
            } else if (isdefined(self.animname)) {
                str_name = self.animname;
            } else if (isdefined(self.targetname)) {
                str_name = self.targetname;
            }
            if (var_109b63b9) {
                print3d(self.origin, self getentnum() + get_ent_type() + "<unknown string>" + str_name, color, 0.8, 0.3);
                print3d(self.origin - (0, 0, 5), "<unknown string>" + animation, color, 0.8, 0.3);
                print3d(self.origin - (0, 0, 7), str_extra_info, color, 0.8, 0.15);
            }
            record3dtext(self getentnum() + get_ent_type() + "<unknown string>" + str_name, self.origin, color, "<unknown string>");
            record3dtext("<unknown string>" + animation, self.origin - (0, 0, 5), color, "<unknown string>");
            record3dtext(str_extra_info, self.origin - (0, 0, 7), color, "<unknown string>");
            render_tag("<unknown string>", "<unknown string>", !var_109b63b9);
            render_tag("<unknown string>", "<unknown string>", !var_109b63b9);
            render_tag("<unknown string>", "<unknown string>", !var_109b63b9);
            render_tag("<unknown string>", "<unknown string>", !var_109b63b9);
            _reset_frame();
            wait(0.05);
        }
    }

    // Namespace animation
    // Params 0, eflags: 0x1 linked
    // namespace_1fb6a2e5<file_0>::function_6596e38
    // Checksum 0x559085f3, Offset: 0x8a8
    // Size: 0x6e
    function get_ent_type() {
        if (isactor(self)) {
            return "<unknown string>";
        }
        if (isvehicle(self)) {
            return "<unknown string>";
        }
        return "<unknown string>" + self.classname + "<unknown string>";
    }

    // Namespace animation
    // Params 0, eflags: 0x1 linked
    // namespace_1fb6a2e5<file_0>::function_b8bf0754
    // Checksum 0x4681cb72, Offset: 0x920
    // Size: 0x24
    function _init_frame() {
        self.v_centroid = self getcentroid();
    }

    // Namespace animation
    // Params 0, eflags: 0x1 linked
    // namespace_1fb6a2e5<file_0>::function_2182aee7
    // Checksum 0x5c8339b3, Offset: 0x950
    // Size: 0x12
    function _reset_frame() {
        self.v_centroid = undefined;
    }

    // Namespace animation
    // Params 3, eflags: 0x1 linked
    // namespace_1fb6a2e5<file_0>::function_9063d1b4
    // Checksum 0xa930cfb8, Offset: 0x970
    // Size: 0x144
    function render_tag(str_tag, str_label, b_recorder_only) {
        if (!isdefined(str_label)) {
            str_label = str_tag;
        }
        if (!isdefined(self.v_centroid)) {
            self.v_centroid = self getcentroid();
        }
        v_tag_org = self gettagorigin(str_tag);
        if (isdefined(v_tag_org)) {
            v_tag_ang = self gettagangles(str_tag);
            anim_origin_render(v_tag_org, v_tag_ang, 2, str_label, b_recorder_only);
            if (!b_recorder_only) {
                line(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), 0.5, 1);
            }
            recordline(self.v_centroid, v_tag_org, (0.3, 0.3, 0.3), "<unknown string>");
        }
    }

    // Namespace animation
    // Params 5, eflags: 0x1 linked
    // namespace_1fb6a2e5<file_0>::function_ff13fef6
    // Checksum 0xe0c0ba68, Offset: 0xac0
    // Size: 0x25c
    function anim_origin_render(org, angles, line_length, str_label, b_recorder_only) {
        if (!isdefined(line_length)) {
            line_length = 6;
        }
        if (isdefined(org) && isdefined(angles)) {
            originendpoint = org + vectorscale(anglestoforward(angles), line_length);
            originrightpoint = org + vectorscale(anglestoright(angles), -1 * line_length);
            originuppoint = org + vectorscale(anglestoup(angles), line_length);
            if (!b_recorder_only) {
                line(org, originendpoint, (1, 0, 0));
                line(org, originrightpoint, (0, 1, 0));
                line(org, originuppoint, (0, 0, 1));
            }
            recordline(org, originendpoint, (1, 0, 0), "<unknown string>");
            recordline(org, originrightpoint, (0, 1, 0), "<unknown string>");
            recordline(org, originuppoint, (0, 0, 1), "<unknown string>");
            if (isdefined(str_label)) {
                if (!b_recorder_only) {
                    print3d(org, str_label, (1, 0.752941, 0.796078), 1, 0.05);
                }
                record3dtext(str_label, org, (1, 0.752941, 0.796078), "<unknown string>");
            }
        }
    }

#/

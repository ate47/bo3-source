#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;

#namespace cp_mi_cairo_infection2_sound;

// Namespace cp_mi_cairo_infection2_sound
// Params 0, eflags: 0x0
// Checksum 0xe77ea78f, Offset: 0x250
// Size: 0x52
function main() {
    level thread function_c0b4eae3();
    level thread rock_gap_1();
    level thread rock_gap_2();
    level thread rock_gap_3();
    level thread function_f744d326();
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0, eflags: 0x0
// Checksum 0x4488515b, Offset: 0x2b0
// Size: 0x91
function function_c0b4eae3() {
    trigger = getent(0, "bells", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_church_bell", (-47231, 3435, 1024));
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0, eflags: 0x0
// Checksum 0x1a72b7c3, Offset: 0x350
// Size: 0x89
function rock_gap_1() {
    trigger = getent(0, "rock_gap_1", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_rock_gap_1", (-21, 112, -692));
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0, eflags: 0x0
// Checksum 0x5e4f1749, Offset: 0x3e8
// Size: 0x89
function rock_gap_2() {
    trigger = getent(0, "rock_gap_2", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_rock_gap_2", (683, -67, -725));
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0, eflags: 0x0
// Checksum 0xa75d090c, Offset: 0x480
// Size: 0x89
function rock_gap_3() {
    trigger = getent(0, "rock_gap_3", "targetname");
    if (!isdefined(trigger)) {
        return;
    }
    while (true) {
        trigger waittill(#"trigger", who);
        if (who isplayer()) {
            playsound(0, "amb_rock_gap_3", (1122, 101, -736));
            break;
        }
    }
}

// Namespace cp_mi_cairo_infection2_sound
// Params 0, eflags: 0x0
// Checksum 0xe6566798, Offset: 0x518
// Size: 0x132
function function_f744d326() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    audio::playloopat("vox_infc_salim_journal_001_salm", (5838, -112, -293));
    audio::playloopat("vox_infc_salim_journal_002_salm", (-8985, 817, -15));
    audio::playloopat("vox_infc_salim_journal_003_salm", (-7119, -1047, -53));
    audio::playloopat("vox_infc_salim_journal_004_salm", (-3796, 702, -187));
    audio::playloopat("vox_infc_salim_journal_005_salm", (-8370, 778, -103));
    audio::playloopat("vox_infc_salim_journal_006_salm", (-67200, -4096, 314));
    audio::playloopat("vox_infc_salim_journal_007_salm", (-48043, -1388, 282));
    audio::playloopat("vox_infc_salim_journal_008_salm", (-47788, 2077, 515));
}


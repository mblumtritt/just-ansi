# frozen_string_literal: true

require_relative '../lib/just-ansi'

puts JustAnsi.bbcode <<~TEXT

  ✅ [b 2]Just Ansi[/b] — 8bit-Colors:[/]

  System Colors
    [on_0] 00 [on_1] 01 [on_2] 02 [on_3] 03 [on_4] 04 [on_5] 05 [on_6] 06 [on_7] 07 [/]
    [on_8] 08 [on_9] 09 [on_a] 0a [on_b] 0b [on_c] 0c [on_d] 0d [on_e] 0e [on_e] 0f [/]

  Grayscale
    [on_e8] e8 [on_e9] e9 [on_ea] ea [on_eb] eb [on_ec] ec [on_ed] ed [on_ee] ee [on_ef] ef [on_f0] f0 [on_f1] f1 [on_f2] f2 [on_f3] f3 [/]
    [on_f4] f4 [on_f5] f5 [on_f6] f6 [on_f7] f7 [on_f8] f8 [on_f9] f9 [on_fa] fa [on_fb] fb [on_fc] fc [on_fd] fd [on_fe] fe [on_ff] ff [/]

  6x6 Color Cubes
    [on_10] 10 [on_11] 11 [on_12] 12 [on_13] 13 [on_14] 14 [on_15] 15 [/]    [on_16] 16 [on_17] 17 [on_18] 18 [on_19] 19 [on_1a] 1a [on_1b] 1b [/]    [on_1c] 1c [on_1d] 1d [on_1e] 1e [on_1f] 1f [on_20] 20 [on_21] 21 [/]
    [on_34] 34 [on_35] 35 [on_36] 36 [on_37] 37 [on_38] 38 [on_39] 39 [/]    [on_3a] 3a [on_3b] 3b [on_3c] 3c [on_3d] 3d [on_3e] 3e [on_3f] 3f [/]    [on_40] 40 [on_41] 41 [on_42] 42 [on_43] 43 [on_44] 44 [on_45] 45 [/]
    [on_58] 58 [on_59] 59 [on_5a] 5a [on_5b] 5b [on_5c] 5c [on_5d] 5d [/]    [on_5e] 5e [on_5f] 5f [on_60] 60 [on_61] 61 [on_62] 62 [on_63] 63 [/]    [on_64] 64 [on_65] 65 [on_66] 66 [on_67] 67 [on_68] 68 [on_69] 69 [/]
    [on_7c] 7c [on_7d] 7d [on_7e] 7e [on_7f] 7f [on_80] 80 [on_81] 81 [/]    [on_82] 82 [on_83] 83 [on_84] 84 [on_85] 85 [on_86] 86 [on_87] 87 [/]    [on_88] 88 [on_89] 89 [on_8a] 8a [on_8b] 8b [on_8c] 8c [on_8d] 8d [/]
    [on_a0] a0 [on_a1] a1 [on_a2] a2 [on_a3] a3 [on_a4] a4 [on_a5] a5 [/]    [on_a6] a6 [on_a7] a7 [on_a8] a8 [on_a9] a9 [on_aa] aa [on_ab] ab [/]    [on_ac] ac [on_ad] ad [on_ae] ae [on_af] af [on_b0] b0 [on_b1] b1 [/]
    [on_c4] c4 [on_c5] c5 [on_c6] c6 [on_c7] c7 [on_c8] c8 [on_c9] c9 [/]    [on_ca] ca [on_cb] cb [on_cc] cc [on_cd] cd [on_ce] ce [on_cf] cf [/]    [on_d0] d0 [on_d1] d1 [on_d2] d2 [on_d3] d3 [on_d4] d4 [on_d5] d5 [/]

    [on_22] 22 [on_23] 23 [on_24] 24 [on_25] 25 [on_26] 26 [on_27] 27 [/]    [on_28] 28 [on_29] 29 [on_2a] 2a [on_2b] 2b [on_2c] 2c [on_2d] 2d [/]    [on_2e] 2e [on_2f] 2f [on_30] 30 [on_31] 31 [on_32] 32 [on_33] 33 [/]
    [on_46] 46 [on_47] 47 [on_48] 48 [on_49] 49 [on_4a] 4a [on_4b] 4b [/]    [on_4c] 4c [on_4d] 4d [on_4e] 4e [on_4f] 4f [on_50] 50 [on_51] 51 [/]    [on_52] 52 [on_53] 53 [on_54] 54 [on_55] 55 [on_56] 56 [on_57] 57 [/]
    [on_6a] 6a [on_6b] 6b [on_6c] 6c [on_6d] 6d [on_6e] 6e [on_6f] 6f [/]    [on_70] 70 [on_71] 71 [on_72] 72 [on_73] 73 [on_74] 74 [on_75] 75 [/]    [on_76] 76 [on_77] 77 [on_78] 78 [on_79] 79 [on_7a] 7a [on_7b] 7b [/]
    [on_8e] 8e [on_8f] 8f [on_90] 90 [on_91] 91 [on_92] 92 [on_93] 93 [/]    [on_94] 94 [on_95] 95 [on_96] 96 [on_97] 97 [on_98] 98 [on_99] 99 [/]    [on_9a] 9a [on_9b] 9b [on_9c] 9c [on_9d] 9d [on_9e] 9e [on_9f] 9f [/]
    [on_b2] b2 [on_b3] b3 [on_b4] b4 [on_b5] b5 [on_b6] b6 [on_b7] b7 [/]    [on_b8] b8 [on_b9] b9 [on_ba] ba [on_bb] bb [on_bc] bc [on_bd] bd [/]    [on_be] be [on_bf] bf [on_c0] c0 [on_c1] c1 [on_c2] c2 [on_c3] c3 [/]
    [on_d6] d6 [on_d7] d7 [on_d8] d8 [on_d9] d9 [on_da] da [on_db] db [/]    [on_dc] dc [on_dd] dd [on_de] de [on_df] df [on_e0] e0 [on_e1] e1 [/]    [on_e2] e2 [on_e3] e3 [on_e4] e4 [on_e5] e5 [on_e6] e6 [on_e7] e7 [/]

TEXT

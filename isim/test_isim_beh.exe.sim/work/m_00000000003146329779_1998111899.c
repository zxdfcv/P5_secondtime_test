/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/10791/P5_secondtime_test/P5_code/MemOp.v";
static unsigned int ng1[] = {0U, 0U};
static int ng2[] = {15, 0};
static int ng3[] = {0, 0};
static unsigned int ng4[] = {1U, 0U};
static int ng5[] = {31, 0};
static int ng6[] = {16, 0};



static void Always_44_0(char *t0)
{
    char t4[8];
    char t5[8];
    char t8[8];
    char t35[8];
    char t49[8];
    char t60[8];
    char t61[8];
    char t62[8];
    char *t1;
    char *t2;
    char *t3;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t36;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    char *t50;
    char *t51;
    char *t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    char *t59;
    char *t63;
    char *t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    unsigned int t69;
    int t70;
    char *t71;
    unsigned int t72;
    int t73;
    int t74;
    char *t75;
    unsigned int t76;
    int t77;
    int t78;
    unsigned int t79;
    int t80;
    unsigned int t81;
    unsigned int t82;
    int t83;
    int t84;

LAB0:    t1 = (t0 + 2848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 3168);
    *((int *)t2) = 1;
    t3 = (t0 + 2880);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(44, ng0);

LAB5:    xsi_set_current_line(45, ng0);
    t6 = (t0 + 1368U);
    t7 = *((char **)t6);
    t6 = ((char*)((ng1)));
    memset(t8, 0, 8);
    t9 = (t7 + 4);
    t10 = (t6 + 4);
    t11 = *((unsigned int *)t7);
    t12 = *((unsigned int *)t6);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB9;

LAB6:    if (t20 != 0)
        goto LAB8;

LAB7:    *((unsigned int *)t8) = 1;

LAB9:    memset(t5, 0, 8);
    t24 = (t8 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 & 1U);
    if (t29 != 0)
        goto LAB10;

LAB11:    if (*((unsigned int *)t24) != 0)
        goto LAB12;

LAB13:    t31 = (t5 + 4);
    t32 = *((unsigned int *)t5);
    t33 = *((unsigned int *)t31);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB14;

LAB15:    t45 = *((unsigned int *)t5);
    t46 = (~(t45));
    t47 = *((unsigned int *)t31);
    t48 = (t46 || t47);
    if (t48 > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t31) > 0)
        goto LAB18;

LAB19:    if (*((unsigned int *)t5) > 0)
        goto LAB20;

LAB21:    memcpy(t4, t49, 8);

LAB22:    t59 = (t0 + 1768);
    t63 = (t0 + 1768);
    t64 = (t63 + 72U);
    t65 = *((char **)t64);
    t66 = ((char*)((ng2)));
    t67 = ((char*)((ng3)));
    xsi_vlog_convert_partindices(t60, t61, t62, ((int*)(t65)), 2, t66, 32, 1, t67, 32, 1);
    t68 = (t60 + 4);
    t69 = *((unsigned int *)t68);
    t70 = (!(t69));
    t71 = (t61 + 4);
    t72 = *((unsigned int *)t71);
    t73 = (!(t72));
    t74 = (t70 && t73);
    t75 = (t62 + 4);
    t76 = *((unsigned int *)t75);
    t77 = (!(t76));
    t78 = (t74 && t77);
    if (t78 == 1)
        goto LAB23;

LAB24:    xsi_set_current_line(46, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng4)));
    memset(t8, 0, 8);
    t6 = (t3 + 4);
    t7 = (t2 + 4);
    t11 = *((unsigned int *)t3);
    t12 = *((unsigned int *)t2);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t6);
    t15 = *((unsigned int *)t7);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t6);
    t19 = *((unsigned int *)t7);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB28;

LAB25:    if (t20 != 0)
        goto LAB27;

LAB26:    *((unsigned int *)t8) = 1;

LAB28:    memset(t5, 0, 8);
    t10 = (t8 + 4);
    t25 = *((unsigned int *)t10);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 & 1U);
    if (t29 != 0)
        goto LAB29;

LAB30:    if (*((unsigned int *)t10) != 0)
        goto LAB31;

LAB32:    t24 = (t5 + 4);
    t32 = *((unsigned int *)t5);
    t33 = *((unsigned int *)t24);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB33;

LAB34:    t45 = *((unsigned int *)t5);
    t46 = (~(t45));
    t47 = *((unsigned int *)t24);
    t48 = (t46 || t47);
    if (t48 > 0)
        goto LAB35;

LAB36:    if (*((unsigned int *)t24) > 0)
        goto LAB37;

LAB38:    if (*((unsigned int *)t5) > 0)
        goto LAB39;

LAB40:    memcpy(t4, t49, 8);

LAB41:    t51 = (t0 + 1768);
    t52 = (t0 + 1768);
    t59 = (t52 + 72U);
    t63 = *((char **)t59);
    t64 = ((char*)((ng5)));
    t65 = ((char*)((ng6)));
    xsi_vlog_convert_partindices(t60, t61, t62, ((int*)(t63)), 2, t64, 32, 1, t65, 32, 1);
    t66 = (t60 + 4);
    t69 = *((unsigned int *)t66);
    t70 = (!(t69));
    t67 = (t61 + 4);
    t72 = *((unsigned int *)t67);
    t73 = (!(t72));
    t74 = (t70 && t73);
    t68 = (t62 + 4);
    t76 = *((unsigned int *)t68);
    t77 = (!(t76));
    t78 = (t74 && t77);
    if (t78 == 1)
        goto LAB42;

LAB43:    goto LAB2;

LAB8:    t23 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB9;

LAB10:    *((unsigned int *)t5) = 1;
    goto LAB13;

LAB12:    t30 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t30) = 1;
    goto LAB13;

LAB14:    t36 = (t0 + 1208U);
    t37 = *((char **)t36);
    memset(t35, 0, 8);
    t36 = (t35 + 4);
    t38 = (t37 + 4);
    t39 = *((unsigned int *)t37);
    t40 = (t39 >> 0);
    *((unsigned int *)t35) = t40;
    t41 = *((unsigned int *)t38);
    t42 = (t41 >> 0);
    *((unsigned int *)t36) = t42;
    t43 = *((unsigned int *)t35);
    *((unsigned int *)t35) = (t43 & 65535U);
    t44 = *((unsigned int *)t36);
    *((unsigned int *)t36) = (t44 & 65535U);
    goto LAB15;

LAB16:    t50 = (t0 + 1048U);
    t51 = *((char **)t50);
    memset(t49, 0, 8);
    t50 = (t49 + 4);
    t52 = (t51 + 4);
    t53 = *((unsigned int *)t51);
    t54 = (t53 >> 0);
    *((unsigned int *)t49) = t54;
    t55 = *((unsigned int *)t52);
    t56 = (t55 >> 0);
    *((unsigned int *)t50) = t56;
    t57 = *((unsigned int *)t49);
    *((unsigned int *)t49) = (t57 & 65535U);
    t58 = *((unsigned int *)t50);
    *((unsigned int *)t50) = (t58 & 65535U);
    goto LAB17;

LAB18:    xsi_vlog_unsigned_bit_combine(t4, 16, t35, 16, t49, 16);
    goto LAB22;

LAB20:    memcpy(t4, t35, 8);
    goto LAB22;

LAB23:    t79 = *((unsigned int *)t62);
    t80 = (t79 + 0);
    t81 = *((unsigned int *)t60);
    t82 = *((unsigned int *)t61);
    t83 = (t81 - t82);
    t84 = (t83 + 1);
    xsi_vlogvar_assign_value(t59, t4, t80, *((unsigned int *)t61), t84);
    goto LAB24;

LAB27:    t9 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t9) = 1;
    goto LAB28;

LAB29:    *((unsigned int *)t5) = 1;
    goto LAB32;

LAB31:    t23 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB32;

LAB33:    t30 = (t0 + 1208U);
    t31 = *((char **)t30);
    memset(t35, 0, 8);
    t30 = (t35 + 4);
    t36 = (t31 + 4);
    t39 = *((unsigned int *)t31);
    t40 = (t39 >> 0);
    *((unsigned int *)t35) = t40;
    t41 = *((unsigned int *)t36);
    t42 = (t41 >> 0);
    *((unsigned int *)t30) = t42;
    t43 = *((unsigned int *)t35);
    *((unsigned int *)t35) = (t43 & 65535U);
    t44 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t44 & 65535U);
    goto LAB34;

LAB35:    t37 = (t0 + 1048U);
    t38 = *((char **)t37);
    memset(t49, 0, 8);
    t37 = (t49 + 4);
    t50 = (t38 + 4);
    t53 = *((unsigned int *)t38);
    t54 = (t53 >> 16);
    *((unsigned int *)t49) = t54;
    t55 = *((unsigned int *)t50);
    t56 = (t55 >> 16);
    *((unsigned int *)t37) = t56;
    t57 = *((unsigned int *)t49);
    *((unsigned int *)t49) = (t57 & 65535U);
    t58 = *((unsigned int *)t37);
    *((unsigned int *)t37) = (t58 & 65535U);
    goto LAB36;

LAB37:    xsi_vlog_unsigned_bit_combine(t4, 16, t35, 16, t49, 16);
    goto LAB41;

LAB39:    memcpy(t4, t35, 8);
    goto LAB41;

LAB42:    t79 = *((unsigned int *)t62);
    t80 = (t79 + 0);
    t81 = *((unsigned int *)t60);
    t82 = *((unsigned int *)t61);
    t83 = (t81 - t82);
    t84 = (t83 + 1);
    xsi_vlogvar_assign_value(t51, t4, t80, *((unsigned int *)t61), t84);
    goto LAB43;

}


extern void work_m_00000000003146329779_1998111899_init()
{
	static char *pe[] = {(void *)Always_44_0};
	xsi_register_didat("work_m_00000000003146329779_1998111899", "isim/test_isim_beh.exe.sim/work/m_00000000003146329779_1998111899.didat");
	xsi_register_executes(pe);
}

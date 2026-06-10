.class public Ltypeinference/TestTypeUpdateMoveRejectLaundering/Run;
.super Ljava/lang/Object;
.source "TestTypeUpdateMoveRejectLaundering.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

# PHI at merge + String USE bound on one branch (normal pipeline, MOVE kept by PHI rule).
.method public static run(Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;Z)V
    .locals 2

    if-eqz p1, :cond_else

    move-object v0, p0

    invoke-virtual {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;->touchA()V

    invoke-virtual {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;->touchB()V

    goto :goto_merge

    :cond_else
    move-object v0, p0

    invoke-static {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Helper;->useString(Ljava/lang/String;)V

    invoke-virtual {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;->touchC()V

    :goto_merge
    invoke-virtual {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;->touchA()V

    invoke-virtual {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;->touchB()V

    return-void
.end method

# Control: same PHI/move shape, but both branches only use Param (no conflicting USE bound).
.method public static runParamPhiOnly(Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;Z)V
    .locals 2

    if-eqz p1, :cond_else

    move-object v0, p0

    invoke-virtual {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;->touchA()V

    goto :goto_merge

    :cond_else
    move-object v0, p0

    invoke-virtual {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;->touchC()V

    :goto_merge
    invoke-virtual {v0}, Ltypeinference/TestTypeUpdateMoveRejectLaundering/Param;->touchB()V

    return-void
.end method

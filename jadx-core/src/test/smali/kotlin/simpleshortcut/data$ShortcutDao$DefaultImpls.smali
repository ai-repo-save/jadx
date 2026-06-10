.class public final Lcom/josski/simpleshortcut/data/ShortcutDao$DefaultImpls;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/josski/simpleshortcut/data/ShortcutDao;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "DefaultImpls"
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method public static synthetic incrementTapCount$default(Lcom/josski/simpleshortcut/data/ShortcutDao;Ljava/lang/String;JLz2/e;ILjava/lang/Object;)Ljava/lang/Object;
    .registers 7

    if-nez p6, :cond_f

    and-int/lit8 p5, p5, 0x2

    if-eqz p5, :cond_a

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide p2

    :cond_a
    invoke-interface {p0, p1, p2, p3, p4}, Lcom/josski/simpleshortcut/data/ShortcutDao;->incrementTapCount(Ljava/lang/String;JLz2/e;)Ljava/lang/Object;

    move-result-object p0

    return-object p0

    :cond_f
    new-instance p0, Ljava/lang/UnsupportedOperationException;

    const-string p1, "Super calls with default arguments not supported in this target, function: incrementTapCount"

    invoke-direct {p0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

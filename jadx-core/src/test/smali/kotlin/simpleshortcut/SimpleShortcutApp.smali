.class public final Lcom/josski/simpleshortcut/SimpleShortcutApp;
.super Landroid/app/Application;
.source "SourceFile"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0018\u00002\u00020\u0001B\u0007\u00a2\u0006\u0004\u0008\u0002\u0010\u0003\u00a8\u0006\u0004"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/SimpleShortcutApp;",
        "Landroid/app/Application;",
        "<init>",
        "()V",
        "app_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
.end annotation


# instance fields
.field public final c:Lu3/e;

.field public final d:Lw2/f;

.field public final e:Lw2/f;


# direct methods
.method public constructor <init>()V
    .registers 3

    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    new-instance v0, Lp3/n1;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lp3/z0;-><init>(Lp3/w0;)V

    invoke-static {v0}, Ld3/b;->h(Lz2/h;)Lu3/e;

    move-result-object v0

    iput-object v0, p0, Lcom/josski/simpleshortcut/SimpleShortcutApp;->c:Lu3/e;

    new-instance v0, Lu2/m0;

    invoke-direct {v0, p0}, Lu2/m0;-><init>(Lcom/josski/simpleshortcut/SimpleShortcutApp;)V

    new-instance v1, Lw2/f;

    invoke-direct {v1, v0}, Lw2/f;-><init>(Lg3/a;)V

    iput-object v1, p0, Lcom/josski/simpleshortcut/SimpleShortcutApp;->d:Lw2/f;

    new-instance v0, Landroidx/lifecycle/x0;

    const/4 v1, 0x3

    invoke-direct {v0, v1, p0}, Landroidx/lifecycle/x0;-><init>(ILjava/lang/Object;)V

    new-instance v1, Lw2/f;

    invoke-direct {v1, v0}, Lw2/f;-><init>(Lg3/a;)V

    iput-object v1, p0, Lcom/josski/simpleshortcut/SimpleShortcutApp;->e:Lw2/f;

    return-void
.end method


# virtual methods
.method public final onCreate()V
    .registers 5

    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    new-instance v0, Lu2/n0;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lu2/n0;-><init>(Lcom/josski/simpleshortcut/SimpleShortcutApp;Lz2/e;)V

    const/4 v2, 0x3

    iget-object v3, p0, Lcom/josski/simpleshortcut/SimpleShortcutApp;->c:Lu3/e;

    invoke-static {v3, v1, v1, v0, v2}, Ld3/b;->S0(Lp3/v;Lp3/s;Lp3/w;Lg3/p;I)Lp3/m1;

    return-void
.end method

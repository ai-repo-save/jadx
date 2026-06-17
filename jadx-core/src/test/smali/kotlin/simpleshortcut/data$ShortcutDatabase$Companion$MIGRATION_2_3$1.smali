.class public final Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;
.super Landroidx/room/migration/Migration;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/josski/simpleshortcut/data/ShortcutDatabase;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0017\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0017\u0010\u0005\u001a\u00020\u00042\u0006\u0010\u0003\u001a\u00020\u0002H\u0016\u00a2\u0006\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u0007"
    }
    d2 = {
        "com/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1",
        "Landroidx/room/migration/Migration;",
        "Lj1/b;",
        "db",
        "Lw2/i;",
        "migrate",
        "(Lj1/b;)V",
        "app_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .registers 3

    const/4 v0, 0x2

    const/4 v1, 0x3

    invoke-direct {p0, v0, v1}, Landroidx/room/migration/Migration;-><init>(II)V

    return-void
.end method


# virtual methods
.method public migrate(Lj1/b;)V
    .registers 3

    const-string v0, "db"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "ALTER TABLE shortcuts ADD COLUMN tapCount INTEGER NOT NULL DEFAULT 0"

    invoke-interface {p1, v0}, Lj1/b;->n(Ljava/lang/String;)V

    const-string v0, "ALTER TABLE shortcuts ADD COLUMN lastUsedAt INTEGER NOT NULL DEFAULT 0"

    invoke-interface {p1, v0}, Lj1/b;->n(Ljava/lang/String;)V

    return-void
.end method

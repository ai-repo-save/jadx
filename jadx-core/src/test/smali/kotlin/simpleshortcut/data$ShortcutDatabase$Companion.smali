.class public final Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/josski/simpleshortcut/data/ShortcutDatabase;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000$\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0008\u0003\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000*\u0002\u0006\t\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u000b\u001a\u00020\u00042\u0006\u0010\u000c\u001a\u00020\rR\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0005\u001a\u00020\u0006X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0007R\u0010\u0010\u0008\u001a\u00020\tX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\n\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;",
        "",
        "()V",
        "INSTANCE",
        "Lcom/josski/simpleshortcut/data/ShortcutDatabase;",
        "MIGRATION_1_2",
        "com/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1",
        "Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1;",
        "MIGRATION_2_3",
        "com/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1",
        "Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;",
        "getDatabase",
        "context",
        "Landroid/content/Context;",
        "app_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lh3/f;)V
    .registers 2

    .line 1
    invoke-direct {p0}, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final getDatabase(Landroid/content/Context;)Lcom/josski/simpleshortcut/data/ShortcutDatabase;
    .registers 6

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->access$getINSTANCE$cp()Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    move-result-object v0

    if-nez v0, :cond_57

    monitor-enter p0

    :try_start_c
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    const-string v0, "getApplicationContext(...)"

    invoke-static {p1, v0}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "shortcut_database"

    invoke-static {v0}, Lo3/g;->p2(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v1, 0x1

    xor-int/2addr v0, v1

    if-eqz v0, :cond_49

    new-instance v0, Landroidx/room/c0;

    invoke-direct {v0, p1}, Landroidx/room/c0;-><init>(Landroid/content/Context;)V

    const/4 p1, 0x2

    new-array p1, p1, [Landroidx/room/migration/Migration;

    invoke-static {}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->access$getMIGRATION_1_2$cp()Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1;

    move-result-object v2

    const/4 v3, 0x0

    aput-object v2, p1, v3

    invoke-static {}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->access$getMIGRATION_2_3$cp()Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;

    move-result-object v2

    aput-object v2, p1, v1

    invoke-virtual {v0, p1}, Landroidx/room/c0;->a([Landroidx/room/migration/Migration;)V

    iput-boolean v3, v0, Landroidx/room/c0;->j:Z

    iput-boolean v1, v0, Landroidx/room/c0;->k:Z

    invoke-virtual {v0}, Landroidx/room/c0;->b()Landroidx/room/e0;

    move-result-object p1

    move-object v0, p1

    check-cast v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    invoke-static {v0}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->access$setINSTANCE$cp(Lcom/josski/simpleshortcut/data/ShortcutDatabase;)V
    :try_end_45
    .catchall {:try_start_c .. :try_end_45} :catchall_47

    monitor-exit p0

    goto :goto_57

    :catchall_47
    move-exception p1

    goto :goto_55

    :cond_49
    :try_start_49
    new-instance p1, Ljava/lang/IllegalArgumentException;

    const-string v0, "Cannot build a database with null or empty name. If you are trying to create an in memory database, use Room.inMemoryDatabaseBuilder"

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p1
    :try_end_55
    .catchall {:try_start_49 .. :try_end_55} :catchall_47

    :goto_55
    monitor-exit p0

    throw p1

    :cond_57
    :goto_57
    return-object v0
.end method

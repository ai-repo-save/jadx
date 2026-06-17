.class public final Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;
.super Lcom/josski/simpleshortcut/data/ShortcutDatabase;
.source "SourceFile"


# instance fields
.field private volatile _shortcutDao:Lcom/josski/simpleshortcut/data/ShortcutDao;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;-><init>()V

    return-void
.end method

.method public static synthetic access$000(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;)Ljava/util/List;
    .registers 1

    iget-object p0, p0, Landroidx/room/e0;->mCallbacks:Ljava/util/List;

    return-object p0
.end method

.method public static synthetic access$100(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;)Ljava/util/List;
    .registers 1

    iget-object p0, p0, Landroidx/room/e0;->mCallbacks:Ljava/util/List;

    return-object p0
.end method

.method public static synthetic access$202(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;Lj1/b;)Lj1/b;
    .registers 2

    iput-object p1, p0, Landroidx/room/e0;->mDatabase:Lj1/b;

    return-object p1
.end method

.method public static synthetic access$300(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;Lj1/b;)V
    .registers 2

    invoke-virtual {p0, p1}, Landroidx/room/e0;->internalInitInvalidationTracker(Lj1/b;)V

    return-void
.end method

.method public static synthetic access$400(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;)Ljava/util/List;
    .registers 1

    iget-object p0, p0, Landroidx/room/e0;->mCallbacks:Ljava/util/List;

    return-object p0
.end method


# virtual methods
.method public clearAllTables()V
    .registers 5

    const-string v0, "VACUUM"

    const-string v1, "PRAGMA wal_checkpoint(FULL)"

    invoke-super {p0}, Landroidx/room/e0;->assertNotMainThread()V

    invoke-super {p0}, Landroidx/room/e0;->getOpenHelper()Lj1/e;

    move-result-object v2

    check-cast v2, Lk1/g;

    invoke-virtual {v2}, Lk1/g;->a()Lj1/b;

    move-result-object v2

    :try_start_11
    invoke-super {p0}, Landroidx/room/e0;->beginTransaction()V

    const-string v3, "DELETE FROM `shortcuts`"

    invoke-interface {v2, v3}, Lj1/b;->n(Ljava/lang/String;)V

    invoke-super {p0}, Landroidx/room/e0;->setTransactionSuccessful()V
    :try_end_1c
    .catchall {:try_start_11 .. :try_end_1c} :catchall_30

    invoke-super {p0}, Landroidx/room/e0;->endTransaction()V

    invoke-interface {v2, v1}, Lj1/b;->q(Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    invoke-interface {v2}, Lj1/b;->t()Z

    move-result v1

    if-nez v1, :cond_2f

    invoke-interface {v2, v0}, Lj1/b;->n(Ljava/lang/String;)V

    :cond_2f
    return-void

    :catchall_30
    move-exception v3

    invoke-super {p0}, Landroidx/room/e0;->endTransaction()V

    invoke-interface {v2, v1}, Lj1/b;->q(Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    invoke-interface {v1}, Landroid/database/Cursor;->close()V

    invoke-interface {v2}, Lj1/b;->t()Z

    move-result v1

    if-nez v1, :cond_44

    invoke-interface {v2, v0}, Lj1/b;->n(Ljava/lang/String;)V

    :cond_44
    throw v3
.end method

.method public createInvalidationTracker()Landroidx/room/u;
    .registers 5

    new-instance v0, Ljava/util/HashMap;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Ljava/util/HashMap;-><init>(I)V

    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2, v1}, Ljava/util/HashMap;-><init>(I)V

    new-instance v1, Landroidx/room/u;

    const-string v3, "shortcuts"

    filled-new-array {v3}, [Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, p0, v0, v2, v3}, Landroidx/room/u;-><init>(Landroidx/room/e0;Ljava/util/HashMap;Ljava/util/HashMap;[Ljava/lang/String;)V

    return-object v1
.end method

.method public createOpenHelper(Landroidx/room/k;)Lj1/e;
    .registers 9

    new-instance v3, Landroidx/room/h0;

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;

    const/4 v1, 0x3

    invoke-direct {v0, p0, v1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;I)V

    invoke-direct {v3, p1, v0}, Landroidx/room/h0;-><init>(Landroidx/room/k;Landroidx/room/f0;)V

    iget-object v1, p1, Landroidx/room/k;->a:Landroid/content/Context;

    const-string v0, "context"

    invoke-static {v1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, p1, Landroidx/room/k;->c:Lj1/d;

    check-cast v0, Lm2/e;

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    new-instance v6, Lk1/g;

    const/4 v4, 0x0

    const/4 v5, 0x0

    iget-object v2, p1, Landroidx/room/k;->b:Ljava/lang/String;

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lk1/g;-><init>(Landroid/content/Context;Ljava/lang/String;Lj1/c;ZZ)V

    return-object v6
.end method

.method public getAutoMigrations(Ljava/util/Map;)Ljava/util/List;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "Ljava/lang/Object;",
            ">;",
            "Ljava/lang/Object;",
            ">;)",
            "Ljava/util/List<",
            "Landroidx/room/migration/Migration;",
            ">;"
        }
    .end annotation

    new-instance p1, Ljava/util/ArrayList;

    invoke-direct {p1}, Ljava/util/ArrayList;-><init>()V

    return-object p1
.end method

.method public getRequiredAutoMigrationSpecs()Ljava/util/Set;
    .registers 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Ljava/lang/Class<",
            "Ljava/lang/Object;",
            ">;>;"
        }
    .end annotation

    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    return-object v0
.end method

.method public getRequiredTypeConverters()Ljava/util/Map;
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/util/List<",
            "Ljava/lang/Class<",
            "*>;>;>;"
        }
    .end annotation

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    const-class v1, Lcom/josski/simpleshortcut/data/ShortcutDao;

    invoke-static {}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->getRequiredConverters()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-object v0
.end method

.method public shortcutDao()Lcom/josski/simpleshortcut/data/ShortcutDao;
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->_shortcutDao:Lcom/josski/simpleshortcut/data/ShortcutDao;

    if-eqz v0, :cond_7

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->_shortcutDao:Lcom/josski/simpleshortcut/data/ShortcutDao;

    return-object v0

    :cond_7
    monitor-enter p0

    :try_start_8
    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->_shortcutDao:Lcom/josski/simpleshortcut/data/ShortcutDao;

    if-nez v0, :cond_16

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-direct {v0, p0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;-><init>(Landroidx/room/e0;)V

    iput-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->_shortcutDao:Lcom/josski/simpleshortcut/data/ShortcutDao;

    goto :goto_16

    :catchall_14
    move-exception v0

    goto :goto_1a

    :cond_16
    :goto_16
    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->_shortcutDao:Lcom/josski/simpleshortcut/data/ShortcutDao;

    monitor-exit p0

    return-object v0

    :goto_1a
    monitor-exit p0
    :try_end_1b
    .catchall {:try_start_8 .. :try_end_1b} :catchall_14

    throw v0
.end method

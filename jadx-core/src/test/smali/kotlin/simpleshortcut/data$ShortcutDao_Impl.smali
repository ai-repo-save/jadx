.class public final Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/josski/simpleshortcut/data/ShortcutDao;


# instance fields
.field private final __db:Landroidx/room/e0;

.field private final __deletionAdapterOfShortcut:Landroidx/room/l;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/room/l;"
        }
    .end annotation
.end field

.field private final __insertionAdapterOfShortcut:Landroidx/room/m;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/room/m;"
        }
    .end annotation
.end field

.field private final __preparedStmtOfIncrementTapCount:Landroidx/room/k0;

.field private final __updateAdapterOfShortcut:Landroidx/room/l;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/room/l;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroidx/room/e0;)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$1;

    invoke-direct {v0, p0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$1;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/e0;)V

    iput-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__insertionAdapterOfShortcut:Landroidx/room/m;

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$2;

    invoke-direct {v0, p0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$2;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/e0;)V

    iput-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__deletionAdapterOfShortcut:Landroidx/room/l;

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$3;

    invoke-direct {v0, p0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$3;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/e0;)V

    iput-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__updateAdapterOfShortcut:Landroidx/room/l;

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$4;

    invoke-direct {v0, p0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$4;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/e0;)V

    iput-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__preparedStmtOfIncrementTapCount:Landroidx/room/k0;

    return-void
.end method

.method public static synthetic access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;
    .registers 1

    iget-object p0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    return-object p0
.end method

.method public static synthetic access$100(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/m;
    .registers 1

    iget-object p0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__insertionAdapterOfShortcut:Landroidx/room/m;

    return-object p0
.end method

.method public static synthetic access$200(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/l;
    .registers 1

    iget-object p0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__deletionAdapterOfShortcut:Landroidx/room/l;

    return-object p0
.end method

.method public static synthetic access$300(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/l;
    .registers 1

    iget-object p0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__updateAdapterOfShortcut:Landroidx/room/l;

    return-object p0
.end method

.method public static synthetic access$400(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/k0;
    .registers 1

    iget-object p0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__preparedStmtOfIncrementTapCount:Landroidx/room/k0;

    return-object p0
.end method

.method public static getRequiredConverters()Ljava/util/List;
    .registers 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/Class<",
            "*>;>;"
        }
    .end annotation

    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public delete(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    new-instance v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;

    invoke-direct {v1, p0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Lcom/josski/simpleshortcut/data/Shortcut;)V

    invoke-static {v0, v1, p2}, Landroidx/room/j;->a(Landroidx/room/e0;Ljava/util/concurrent/Callable;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public getAllCategories()Ls3/e;
    .registers 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ls3/e;"
        }
    .end annotation

    const-string v0, "SELECT DISTINCT category FROM shortcuts WHERE category != \'\' ORDER BY category ASC"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroidx/room/i0;->g(Ljava/lang/String;I)Landroidx/room/i0;

    move-result-object v0

    iget-object v3, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    const-string v1, "shortcuts"

    filled-new-array {v1}, [Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;

    invoke-direct {v5, p0, v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/i0;)V

    new-instance v0, Landroidx/room/g;

    const/4 v6, 0x0

    const/4 v2, 0x0

    move-object v1, v0

    invoke-direct/range {v1 .. v6}, Landroidx/room/g;-><init>(ZLandroidx/room/e0;[Ljava/lang/String;Ljava/util/concurrent/Callable;Lz2/e;)V

    new-instance v1, Ls3/g;

    invoke-direct {v1, v0}, Ls3/g;-><init>(Lg3/p;)V

    return-object v1
.end method

.method public getAllShortcuts()Ls3/e;
    .registers 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ls3/e;"
        }
    .end annotation

    const-string v0, "SELECT * FROM shortcuts ORDER BY rank ASC, createdAt DESC"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroidx/room/i0;->g(Ljava/lang/String;I)Landroidx/room/i0;

    move-result-object v0

    iget-object v3, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    const-string v1, "shortcuts"

    filled-new-array {v1}, [Ljava/lang/String;

    move-result-object v4

    new-instance v5, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;

    invoke-direct {v5, p0, v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/i0;)V

    new-instance v0, Landroidx/room/g;

    const/4 v6, 0x0

    const/4 v2, 0x0

    move-object v1, v0

    invoke-direct/range {v1 .. v6}, Landroidx/room/g;-><init>(ZLandroidx/room/e0;[Ljava/lang/String;Ljava/util/concurrent/Callable;Lz2/e;)V

    new-instance v1, Ls3/g;

    invoke-direct {v1, v0}, Ls3/g;-><init>(Lg3/p;)V

    return-object v1
.end method

.method public getAllShortcutsSync()Ljava/util/List;
    .registers 31
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;"
        }
    .end annotation

    move-object/from16 v1, p0

    const-string v0, "SELECT * FROM shortcuts ORDER BY rank ASC, createdAt DESC"

    const/4 v2, 0x0

    invoke-static {v0, v2}, Landroidx/room/i0;->g(Ljava/lang/String;I)Landroidx/room/i0;

    move-result-object v3

    iget-object v0, v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    invoke-virtual {v0}, Landroidx/room/e0;->assertNotSuspendingTransaction()V

    iget-object v0, v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    invoke-static {v0, v3}, Ld3/b;->r1(Landroidx/room/e0;Landroidx/room/i0;)Landroid/database/Cursor;

    move-result-object v4

    :try_start_14
    const-string v0, "id"

    invoke-static {v4, v0}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v0

    const-string v5, "label"

    invoke-static {v4, v5}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v5

    const-string v6, "packageName"

    invoke-static {v4, v6}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v6

    const-string v7, "deeplink"

    invoke-static {v4, v7}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v7

    const-string v8, "emoji"

    invoke-static {v4, v8}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v8

    const-string v9, "rank"

    invoke-static {v4, v9}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v9

    const-string v10, "createdAt"

    invoke-static {v4, v10}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v10

    const-string v11, "category"

    invoke-static {v4, v11}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v11

    const-string v12, "isPinned"

    invoke-static {v4, v12}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v12

    const-string v13, "tapCount"

    invoke-static {v4, v13}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v13

    const-string v14, "lastUsedAt"

    invoke-static {v4, v14}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v14

    new-instance v15, Ljava/util/ArrayList;

    invoke-interface {v4}, Landroid/database/Cursor;->getCount()I

    move-result v2

    invoke-direct {v15, v2}, Ljava/util/ArrayList;-><init>(I)V

    :goto_5f
    invoke-interface {v4}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_a6

    invoke-interface {v4, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v17

    invoke-interface {v4, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v18

    invoke-interface {v4, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v19

    invoke-interface {v4, v7}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v20

    invoke-interface {v4, v8}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v21

    invoke-interface {v4, v9}, Landroid/database/Cursor;->getInt(I)I

    move-result v22

    invoke-interface {v4, v10}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v23

    invoke-interface {v4, v11}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v25

    invoke-interface {v4, v12}, Landroid/database/Cursor;->getInt(I)I

    move-result v2

    if-eqz v2, :cond_8f

    const/4 v2, 0x1

    move/from16 v26, v2

    goto :goto_91

    :cond_8f
    const/16 v26, 0x0

    :goto_91
    invoke-interface {v4, v13}, Landroid/database/Cursor;->getInt(I)I

    move-result v27

    invoke-interface {v4, v14}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v28

    new-instance v2, Lcom/josski/simpleshortcut/data/Shortcut;

    move-object/from16 v16, v2

    invoke-direct/range {v16 .. v29}, Lcom/josski/simpleshortcut/data/Shortcut;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJLjava/lang/String;ZIJ)V

    invoke-virtual {v15, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_a3
    .catchall {:try_start_14 .. :try_end_a3} :catchall_a4

    goto :goto_5f

    :catchall_a4
    move-exception v0

    goto :goto_ad

    :cond_a6
    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    invoke-virtual {v3}, Landroidx/room/i0;->i()V

    return-object v15

    :goto_ad
    invoke-interface {v4}, Landroid/database/Cursor;->close()V

    invoke-virtual {v3}, Landroidx/room/i0;->i()V

    throw v0
.end method

.method public getByCategory(Ljava/lang/String;)Ls3/e;
    .registers 10
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ls3/e;"
        }
    .end annotation

    const-string v0, "SELECT * FROM shortcuts WHERE category = ? ORDER BY rank ASC, createdAt DESC"

    const/4 v1, 0x1

    invoke-static {v0, v1}, Landroidx/room/i0;->g(Ljava/lang/String;I)Landroidx/room/i0;

    move-result-object v0

    invoke-virtual {v0, p1, v1}, Landroidx/room/i0;->h(Ljava/lang/String;I)V

    iget-object v4, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    const-string p1, "shortcuts"

    filled-new-array {p1}, [Ljava/lang/String;

    move-result-object v5

    new-instance v6, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$13;

    invoke-direct {v6, p0, v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$13;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/i0;)V

    new-instance p1, Landroidx/room/g;

    const/4 v7, 0x0

    const/4 v3, 0x0

    move-object v2, p1

    invoke-direct/range {v2 .. v7}, Landroidx/room/g;-><init>(ZLandroidx/room/e0;[Ljava/lang/String;Ljava/util/concurrent/Callable;Lz2/e;)V

    new-instance v0, Ls3/g;

    invoke-direct {v0, p1}, Ls3/g;-><init>(Lg3/p;)V

    return-object v0
.end method

.method public getById(Ljava/lang/String;Lz2/e;)Ljava/lang/Object;
    .registers 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    const-string v0, "SELECT * FROM shortcuts WHERE id = ?"

    const/4 v1, 0x1

    invoke-static {v0, v1}, Landroidx/room/i0;->g(Ljava/lang/String;I)Landroidx/room/i0;

    move-result-object v0

    invoke-virtual {v0, p1, v1}, Landroidx/room/i0;->h(Ljava/lang/String;I)V

    new-instance p1, Landroid/os/CancellationSignal;

    invoke-direct {p1}, Landroid/os/CancellationSignal;-><init>()V

    iget-object v2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    new-instance v3, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;

    invoke-direct {v3, p0, v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/i0;)V

    invoke-virtual {v2}, Landroidx/room/e0;->isOpenInternal()Z

    move-result v0

    if-eqz v0, :cond_27

    invoke-virtual {v2}, Landroidx/room/e0;->inTransaction()Z

    move-result v0

    if-eqz v0, :cond_27

    invoke-interface {v3}, Ljava/util/concurrent/Callable;->call()Ljava/lang/Object;

    move-result-object p1

    goto :goto_5d

    :cond_27
    invoke-interface {p2}, Lz2/e;->getContext()Lz2/j;

    move-result-object v0

    sget-object v4, Landroidx/room/l0;->c:Lm2/e;

    invoke-interface {v0, v4}, Lz2/j;->g(Lz2/i;)Lz2/h;

    move-result-object v0

    invoke-static {v0}, La/i;->j(Lz2/h;)V

    invoke-static {v2}, Ld3/b;->w0(Landroidx/room/e0;)Lp3/s;

    move-result-object v0

    new-instance v2, Lp3/g;

    invoke-static {p2}, Ld3/b;->E0(Lz2/e;)Lz2/e;

    move-result-object p2

    invoke-direct {v2, v1, p2}, Lp3/g;-><init>(ILz2/e;)V

    invoke-virtual {v2}, Lp3/g;->r()V

    sget-object p2, Lp3/o0;->c:Lp3/o0;

    new-instance v4, Landroidx/room/i;

    const/4 v5, 0x0

    invoke-direct {v4, v3, v2, v5}, Landroidx/room/i;-><init>(Ljava/util/concurrent/Callable;Lp3/f;Lz2/e;)V

    const/4 v3, 0x2

    invoke-static {p2, v0, v5, v4, v3}, Ld3/b;->S0(Lp3/v;Lp3/s;Lp3/w;Lg3/p;I)Lp3/m1;

    move-result-object p2

    new-instance v0, Landroidx/room/b;

    invoke-direct {v0, p1, v1, p2}, Landroidx/room/b;-><init>(Ljava/lang/Object;ILjava/lang/Object;)V

    invoke-virtual {v2, v0}, Lp3/g;->t(Landroidx/room/b;)V

    invoke-virtual {v2}, Lp3/g;->q()Ljava/lang/Object;

    move-result-object p1

    :goto_5d
    return-object p1
.end method

.method public incrementTapCount(Ljava/lang/String;JLz2/e;)Ljava/lang/Object;
    .registers 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "J",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    new-instance v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;

    invoke-direct {v1, p0, p2, p3, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;JLjava/lang/String;)V

    invoke-static {v0, v1, p4}, Landroidx/room/j;->a(Landroidx/room/e0;Ljava/util/concurrent/Callable;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public insert(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    new-instance v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$5;

    invoke-direct {v1, p0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$5;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Lcom/josski/simpleshortcut/data/Shortcut;)V

    invoke-static {v0, v1, p2}, Landroidx/room/j;->a(Landroidx/room/e0;Ljava/util/concurrent/Callable;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public search(Ljava/lang/String;)Ls3/e;
    .registers 11
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ls3/e;"
        }
    .end annotation

    const-string v0, "SELECT * FROM shortcuts WHERE label LIKE \'%\' || ? || \'%\' OR packageName LIKE \'%\' || ? || \'%\' OR deeplink LIKE \'%\' || ? || \'%\' ORDER BY rank ASC"

    const/4 v1, 0x3

    invoke-static {v0, v1}, Landroidx/room/i0;->g(Ljava/lang/String;I)Landroidx/room/i0;

    move-result-object v0

    const/4 v2, 0x1

    invoke-virtual {v0, p1, v2}, Landroidx/room/i0;->h(Ljava/lang/String;I)V

    const/4 v2, 0x2

    invoke-virtual {v0, p1, v2}, Landroidx/room/i0;->h(Ljava/lang/String;I)V

    invoke-virtual {v0, p1, v1}, Landroidx/room/i0;->h(Ljava/lang/String;I)V

    iget-object v5, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    const-string p1, "shortcuts"

    filled-new-array {p1}, [Ljava/lang/String;

    move-result-object v6

    new-instance v7, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$14;

    invoke-direct {v7, p0, v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$14;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/i0;)V

    new-instance p1, Landroidx/room/g;

    const/4 v8, 0x0

    const/4 v4, 0x0

    move-object v3, p1

    invoke-direct/range {v3 .. v8}, Landroidx/room/g;-><init>(ZLandroidx/room/e0;[Ljava/lang/String;Ljava/util/concurrent/Callable;Lz2/e;)V

    new-instance v0, Ls3/g;

    invoke-direct {v0, p1}, Ls3/g;-><init>(Lg3/p;)V

    return-object v0
.end method

.method public update(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    new-instance v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$7;

    invoke-direct {v1, p0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$7;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Lcom/josski/simpleshortcut/data/Shortcut;)V

    invoke-static {v0, v1, p2}, Landroidx/room/j;->a(Landroidx/room/e0;Ljava/util/concurrent/Callable;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public updateAll(Ljava/util/List;Lz2/e;)Ljava/lang/Object;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->__db:Landroidx/room/e0;

    new-instance v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$8;

    invoke-direct {v1, p0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$8;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Ljava/util/List;)V

    invoke-static {v0, v1, p2}, Landroidx/room/j;->a(Landroidx/room/e0;Ljava/util/concurrent/Callable;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

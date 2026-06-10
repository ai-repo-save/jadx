.class Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;
.super Landroidx/room/f0;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->createOpenHelper(Landroidx/room/k;)Lj1/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;I)V
    .registers 3

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;

    invoke-direct {p0, p2}, Landroidx/room/f0;-><init>(I)V

    return-void
.end method


# virtual methods
.method public createAllTables(Lj1/b;)V
    .registers 3

    const-string v0, "CREATE TABLE IF NOT EXISTS `shortcuts` (`id` TEXT NOT NULL, `label` TEXT NOT NULL, `packageName` TEXT NOT NULL, `deeplink` TEXT NOT NULL, `emoji` TEXT NOT NULL, `rank` INTEGER NOT NULL, `createdAt` INTEGER NOT NULL, `category` TEXT NOT NULL DEFAULT \'\', `isPinned` INTEGER NOT NULL DEFAULT 0, `tapCount` INTEGER NOT NULL DEFAULT 0, `lastUsedAt` INTEGER NOT NULL DEFAULT 0, PRIMARY KEY(`id`))"

    invoke-interface {p1, v0}, Lj1/b;->n(Ljava/lang/String;)V

    const-string v0, "CREATE TABLE IF NOT EXISTS room_master_table (id INTEGER PRIMARY KEY,identity_hash TEXT)"

    invoke-interface {p1, v0}, Lj1/b;->n(Ljava/lang/String;)V

    const-string v0, "INSERT OR REPLACE INTO room_master_table (id,identity_hash) VALUES(42, \'b7859164b52213414c21c791127c0ed1\')"

    invoke-interface {p1, v0}, Lj1/b;->n(Ljava/lang/String;)V

    return-void
.end method

.method public dropAllTables(Lj1/b;)V
    .registers 3

    const-string v0, "DROP TABLE IF EXISTS `shortcuts`"

    invoke-interface {p1, v0}, Lj1/b;->n(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;

    invoke-static {p1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_21

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_18

    goto :goto_21

    :cond_18
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p1

    invoke-static {p1}, La/i;->i(Ljava/lang/Object;)V

    const/4 p1, 0x0

    throw p1

    :cond_21
    :goto_21
    return-void
.end method

.method public onCreate(Lj1/b;)V
    .registers 3

    iget-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;

    invoke-static {p1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->access$100(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_1c

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_13

    goto :goto_1c

    :cond_13
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p1

    invoke-static {p1}, La/i;->i(Ljava/lang/Object;)V

    const/4 p1, 0x0

    throw p1

    :cond_1c
    :goto_1c
    return-void
.end method

.method public onOpen(Lj1/b;)V
    .registers 3

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;

    invoke-static {v0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->access$202(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;Lj1/b;)Lj1/b;

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;

    invoke-static {v0, p1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->access$300(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;Lj1/b;)V

    iget-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl$1;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;

    invoke-static {p1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;->access$400(Lcom/josski/simpleshortcut/data/ShortcutDatabase_Impl;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_26

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-nez v0, :cond_1d

    goto :goto_26

    :cond_1d
    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p1

    invoke-static {p1}, La/i;->i(Ljava/lang/Object;)V

    const/4 p1, 0x0

    throw p1

    :cond_26
    :goto_26
    return-void
.end method

.method public onPostMigrate(Lj1/b;)V
    .registers 2

    return-void
.end method

.method public onPreMigrate(Lj1/b;)V
    .registers 6

    const-string v0, "db"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Ly2/b;

    invoke-direct {v0}, Ly2/b;-><init>()V

    const-string v1, "SELECT name FROM sqlite_master WHERE type = \'trigger\'"

    invoke-interface {p1, v1}, Lj1/b;->q(Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v1

    :goto_10
    :try_start_10
    invoke-interface {v1}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    const/4 v3, 0x0

    if-eqz v2, :cond_21

    invoke-interface {v1, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ly2/b;->add(Ljava/lang/Object;)Z
    :try_end_1e
    .catchall {:try_start_10 .. :try_end_1e} :catchall_1f

    goto :goto_10

    :catchall_1f
    move-exception p1

    goto :goto_54

    :cond_21
    const/4 v2, 0x0

    invoke-static {v1, v2}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    invoke-static {v0}, Ld3/b;->q(Ly2/b;)Ly2/b;

    move-result-object v0

    invoke-virtual {v0, v3}, Ly2/b;->listIterator(I)Ljava/util/ListIterator;

    move-result-object v0

    :cond_2d
    :goto_2d
    move-object v1, v0

    check-cast v1, Ly2/a;

    invoke-virtual {v1}, Ly2/a;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_53

    invoke-virtual {v1}, Ly2/a;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    const-string v2, "triggerName"

    invoke-static {v1, v2}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v2, "room_fts_content_sync_"

    invoke-virtual {v1, v2}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2d

    const-string v2, "DROP TRIGGER IF EXISTS "

    invoke-virtual {v2, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1}, Lj1/b;->n(Ljava/lang/String;)V

    goto :goto_2d

    :cond_53
    return-void

    :goto_54
    :try_start_54
    throw p1
    :try_end_55
    .catchall {:try_start_54 .. :try_end_55} :catchall_55

    :catchall_55
    move-exception v0

    invoke-static {v1, p1}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v0
.end method

.method public onValidateSchema(Lj1/b;)Landroidx/room/g0;
    .registers 28

    move-object/from16 v0, p1

    const-string v1, "seq"

    new-instance v2, Ljava/util/HashMap;

    const/16 v3, 0xb

    invoke-direct {v2, v3}, Ljava/util/HashMap;-><init>(I)V

    new-instance v3, Lh1/a;

    const/4 v7, 0x1

    const/4 v8, 0x1

    const-string v5, "id"

    const-string v6, "TEXT"

    const/4 v9, 0x0

    const/4 v10, 0x1

    move-object v4, v3

    invoke-direct/range {v4 .. v10}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v4, "id"

    invoke-virtual {v2, v4, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const/4 v9, 0x0

    const-string v6, "label"

    const-string v7, "TEXT"

    const/4 v10, 0x0

    const/4 v11, 0x1

    move-object v5, v3

    invoke-direct/range {v5 .. v11}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "label"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const/4 v9, 0x1

    const/4 v10, 0x0

    const-string v7, "packageName"

    const-string v8, "TEXT"

    const/4 v11, 0x0

    const/4 v12, 0x1

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "packageName"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const-string v7, "deeplink"

    const-string v8, "TEXT"

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "deeplink"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const-string v7, "emoji"

    const-string v8, "TEXT"

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "emoji"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const-string v7, "rank"

    const-string v8, "INTEGER"

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "rank"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const-string v7, "createdAt"

    const-string v8, "INTEGER"

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "createdAt"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const-string v7, "category"

    const-string v8, "TEXT"

    const-string v11, "\'\'"

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "category"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const-string v7, "isPinned"

    const-string v8, "INTEGER"

    const-string v11, "0"

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "isPinned"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const-string v7, "tapCount"

    const-string v8, "INTEGER"

    const-string v11, "0"

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "tapCount"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Lh1/a;

    const-string v7, "lastUsedAt"

    const-string v8, "INTEGER"

    const-string v11, "0"

    move-object v6, v3

    invoke-direct/range {v6 .. v12}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    const-string v5, "lastUsedAt"

    invoke-virtual {v2, v5, v3}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    new-instance v3, Ljava/util/HashSet;

    const/4 v5, 0x0

    invoke-direct {v3, v5}, Ljava/util/HashSet;-><init>(I)V

    new-instance v6, Ljava/util/HashSet;

    invoke-direct {v6, v5}, Ljava/util/HashSet;-><init>(I)V

    new-instance v7, Lh1/e;

    invoke-direct {v7, v2, v3, v6}, Lh1/e;-><init>(Ljava/util/Map;Ljava/util/AbstractSet;Ljava/util/AbstractSet;)V

    const-string v2, "database"

    invoke-static {v0, v2}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v2, "type"

    const-string v3, "PRAGMA table_info(`shortcuts`)"

    invoke-interface {v0, v3}, Lj1/b;->q(Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v3

    :try_start_e0
    invoke-interface {v3}, Landroid/database/Cursor;->getColumnCount()I

    move-result v6
    :try_end_e4
    .catchall {:try_start_e0 .. :try_end_e4} :catchall_14b

    const-string v8, "name"

    const/4 v10, 0x0

    if-gtz v6, :cond_f2

    :try_start_e9
    sget-object v2, Lx2/o;->c:Lx2/o;
    :try_end_eb
    .catchall {:try_start_e9 .. :try_end_eb} :catchall_14b

    invoke-static {v3, v10}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    goto :goto_155

    :goto_ef
    move-object v1, v0

    goto/16 :goto_41d

    :cond_f2
    :try_start_f2
    invoke-interface {v3, v8}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    invoke-interface {v3, v2}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v11

    const-string v12, "notnull"

    invoke-interface {v3, v12}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v12

    const-string v13, "pk"

    invoke-interface {v3, v13}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v13

    const-string v14, "dflt_value"

    invoke-interface {v3, v14}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v14

    new-instance v15, Ly2/e;

    invoke-direct {v15}, Ly2/e;-><init>()V

    :goto_111
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z

    move-result v16

    if-eqz v16, :cond_14d

    invoke-interface {v3, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v3, v11}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-interface {v3, v12}, Landroid/database/Cursor;->getInt(I)I

    move-result v17

    if-eqz v17, :cond_128

    const/16 v20, 0x1

    goto :goto_12a

    :cond_128
    const/16 v20, 0x0

    :goto_12a
    invoke-interface {v3, v13}, Landroid/database/Cursor;->getInt(I)I

    move-result v21

    invoke-interface {v3, v14}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v22

    invoke-static {v5, v8}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v10, Lh1/a;

    invoke-static {v9, v2}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v23, 0x2

    move-object/from16 v17, v10

    move-object/from16 v18, v5

    move-object/from16 v19, v9

    invoke-direct/range {v17 .. v23}, Lh1/a;-><init>(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/String;I)V

    invoke-virtual {v15, v5, v10}, Ly2/e;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v5, 0x0

    const/4 v10, 0x0

    goto :goto_111

    :catchall_14b
    move-exception v0

    goto :goto_ef

    :cond_14d
    invoke-virtual {v15}, Ly2/e;->b()Ly2/e;

    move-result-object v2
    :try_end_151
    .catchall {:try_start_f2 .. :try_end_151} :catchall_14b

    const/4 v5, 0x0

    invoke-static {v3, v5}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    :goto_155
    const-string v3, "PRAGMA foreign_key_list(`shortcuts`)"

    invoke-interface {v0, v3}, Lj1/b;->q(Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v3

    :try_start_15b
    invoke-interface {v3, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v5

    invoke-interface {v3, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    const-string v9, "table"

    invoke-interface {v3, v9}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v9

    const-string v10, "on_delete"

    invoke-interface {v3, v10}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v10

    const-string v11, "on_update"

    invoke-interface {v3, v11}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v11

    invoke-interface {v3, v4}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    invoke-interface {v3, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    const-string v12, "from"

    invoke-interface {v3, v12}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v12

    const-string v13, "to"

    invoke-interface {v3, v13}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v13

    new-instance v14, Ly2/b;

    invoke-direct {v14}, Ly2/b;-><init>()V

    :goto_18e
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z

    move-result v15

    if-eqz v15, :cond_1cb

    new-instance v15, Lh1/c;

    move-object/from16 v17, v7

    invoke-interface {v3, v4}, Landroid/database/Cursor;->getInt(I)I

    move-result v7

    move/from16 v18, v4

    invoke-interface {v3, v1}, Landroid/database/Cursor;->getInt(I)I

    move-result v4

    move/from16 v19, v1

    invoke-interface {v3, v12}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v1

    move/from16 v20, v12

    const-string v12, "cursor.getString(fromColumnIndex)"

    invoke-static {v1, v12}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3, v13}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v12

    move/from16 v21, v13

    const-string v13, "cursor.getString(toColumnIndex)"

    invoke-static {v12, v13}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v15, v7, v4, v1, v12}, Lh1/c;-><init>(IILjava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v14, v15}, Ly2/b;->add(Ljava/lang/Object;)Z

    move-object/from16 v7, v17

    move/from16 v4, v18

    move/from16 v1, v19

    move/from16 v12, v20

    move/from16 v13, v21

    goto :goto_18e

    :cond_1cb
    move-object/from16 v17, v7

    invoke-static {v14}, Ld3/b;->q(Ly2/b;)Ly2/b;

    move-result-object v1

    const-string v4, "<this>"

    invoke-static {v1, v4}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1}, Ly2/b;->a()I

    move-result v4

    const/4 v7, 0x1

    if-gt v4, v7, :cond_1e2

    invoke-static {v1}, Lx2/l;->w2(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v1

    goto :goto_1f7

    :cond_1e2
    const/4 v4, 0x0

    new-array v7, v4, [Ljava/lang/Comparable;

    invoke-virtual {v1, v7}, Ly2/b;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    move-object v4, v1

    check-cast v4, [Ljava/lang/Comparable;

    array-length v7, v4

    const/4 v12, 0x1

    if-le v7, v12, :cond_1f3

    invoke-static {v4}, Ljava/util/Arrays;->sort([Ljava/lang/Object;)V

    :cond_1f3
    invoke-static {v1}, Lx2/i;->j2([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    :goto_1f7
    const/4 v4, -0x1

    invoke-interface {v3, v4}, Landroid/database/Cursor;->moveToPosition(I)Z

    new-instance v7, Ly2/h;

    invoke-direct {v7}, Ly2/h;-><init>()V

    :goto_200
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z

    move-result v12

    if-eqz v12, :cond_297

    invoke-interface {v3, v6}, Landroid/database/Cursor;->getInt(I)I

    move-result v12

    if-eqz v12, :cond_20d

    goto :goto_200

    :cond_20d
    invoke-interface {v3, v5}, Landroid/database/Cursor;->getInt(I)I

    move-result v12

    new-instance v13, Ljava/util/ArrayList;

    invoke-direct {v13}, Ljava/util/ArrayList;-><init>()V

    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    new-instance v15, Ljava/util/ArrayList;

    invoke-direct {v15}, Ljava/util/ArrayList;-><init>()V

    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v18

    :goto_224
    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->hasNext()Z

    move-result v19

    if-eqz v19, :cond_242

    invoke-interface/range {v18 .. v18}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    move-object/from16 v24, v1

    move-object v1, v4

    check-cast v1, Lh1/c;

    iget v1, v1, Lh1/c;->c:I

    if-ne v1, v12, :cond_23a

    invoke-virtual {v15, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    :cond_23a
    move-object/from16 v1, v24

    const/4 v4, -0x1

    goto :goto_224

    :catchall_23e
    move-exception v0

    move-object v1, v0

    goto/16 :goto_416

    :cond_242
    move-object/from16 v24, v1

    invoke-virtual {v15}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_248
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_25f

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lh1/c;

    iget-object v12, v4, Lh1/c;->e:Ljava/lang/String;

    invoke-virtual {v13, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v4, v4, Lh1/c;->f:Ljava/lang/String;

    invoke-virtual {v14, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_248

    :cond_25f
    new-instance v1, Lh1/b;

    invoke-interface {v3, v9}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v4

    const-string v12, "cursor.getString(tableColumnIndex)"

    invoke-static {v4, v12}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3, v10}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v12

    const-string v15, "cursor.getString(onDeleteColumnIndex)"

    invoke-static {v12, v15}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v3, v11}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v15

    move/from16 v25, v5

    const-string v5, "cursor.getString(onUpdateColumnIndex)"

    invoke-static {v15, v5}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    move-object/from16 v18, v1

    move-object/from16 v19, v4

    move-object/from16 v20, v12

    move-object/from16 v21, v15

    move-object/from16 v22, v13

    move-object/from16 v23, v14

    invoke-direct/range {v18 .. v23}, Lh1/b;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    invoke-virtual {v7, v1}, Ly2/h;->add(Ljava/lang/Object;)Z

    move-object/from16 v1, v24

    move/from16 v5, v25

    const/4 v4, -0x1

    goto/16 :goto_200

    :cond_297
    invoke-static {v7}, Ld3/b;->r(Ly2/h;)Ly2/h;

    move-result-object v1
    :try_end_29b
    .catchall {:try_start_15b .. :try_end_29b} :catchall_23e

    const/4 v4, 0x0

    invoke-static {v3, v4}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    const-string v3, "PRAGMA index_list(`shortcuts`)"

    invoke-interface {v0, v3}, Lj1/b;->q(Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v3

    :try_start_2a5
    invoke-interface {v3, v8}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v4

    const-string v5, "origin"

    invoke-interface {v3, v5}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v5

    const-string v6, "unique"

    invoke-interface {v3, v6}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v6

    const/4 v7, -0x1

    if-eq v4, v7, :cond_2bc

    if-eq v5, v7, :cond_2bc

    if-ne v6, v7, :cond_2bf

    :cond_2bc
    const/4 v0, 0x0

    goto/16 :goto_3d9

    :cond_2bf
    new-instance v7, Ly2/h;

    invoke-direct {v7}, Ly2/h;-><init>()V

    :goto_2c4
    invoke-interface {v3}, Landroid/database/Cursor;->moveToNext()Z

    move-result v9

    if-eqz v9, :cond_3cf

    invoke-interface {v3, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    const-string v10, "c"

    invoke-static {v10, v9}, Ld3/b;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_2d7

    goto :goto_2c4

    :cond_2d7
    invoke-interface {v3, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v9

    invoke-interface {v3, v6}, Landroid/database/Cursor;->getInt(I)I

    move-result v10

    const/4 v11, 0x1

    if-ne v10, v11, :cond_2e4

    const/4 v10, 0x1

    goto :goto_2e5

    :cond_2e4
    const/4 v10, 0x0

    :goto_2e5
    invoke-static {v9, v8}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v11, Ljava/lang/StringBuilder;

    const-string v12, "PRAGMA index_xinfo(`"

    invoke-direct {v11, v12}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v11, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v12, "`)"

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-interface {v0, v11}, Lj1/b;->q(Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v11
    :try_end_2ff
    .catchall {:try_start_2a5 .. :try_end_2ff} :catchall_3c5

    :try_start_2ff
    const-string v12, "seqno"

    invoke-interface {v11, v12}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v12

    const-string v13, "cid"

    invoke-interface {v11, v13}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v13

    invoke-interface {v11, v8}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v14

    const-string v15, "desc"

    invoke-interface {v11, v15}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v15

    const/4 v0, -0x1

    if-eq v12, v0, :cond_31e

    if-eq v13, v0, :cond_31e

    if-eq v14, v0, :cond_31e

    if-ne v15, v0, :cond_329

    :cond_31e
    move/from16 v18, v4

    move/from16 v20, v5

    move/from16 v22, v6

    move-object/from16 v21, v8

    const/4 v0, 0x0

    goto/16 :goto_3ab

    :cond_329
    new-instance v0, Ljava/util/TreeMap;

    invoke-direct {v0}, Ljava/util/TreeMap;-><init>()V

    move/from16 v18, v4

    new-instance v4, Ljava/util/TreeMap;

    invoke-direct {v4}, Ljava/util/TreeMap;-><init>()V

    :goto_335
    invoke-interface {v11}, Landroid/database/Cursor;->moveToNext()Z

    move-result v19

    if-eqz v19, :cond_380

    invoke-interface {v11, v13}, Landroid/database/Cursor;->getInt(I)I

    move-result v19

    if-gez v19, :cond_342

    goto :goto_335

    :cond_342
    invoke-interface {v11, v12}, Landroid/database/Cursor;->getInt(I)I

    move-result v19

    move/from16 v20, v5

    invoke-interface {v11, v14}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v11, v15}, Landroid/database/Cursor;->getInt(I)I

    move-result v21

    if-lez v21, :cond_35f

    const-string v21, "DESC"

    :goto_354
    move/from16 v22, v6

    move-object/from16 v6, v21

    move-object/from16 v21, v8

    goto :goto_362

    :catchall_35b
    move-exception v0

    move-object v1, v0

    goto/16 :goto_3c8

    :cond_35f
    const-string v21, "ASC"

    goto :goto_354

    :goto_362
    invoke-static/range {v19 .. v19}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v8

    move/from16 v23, v12

    const-string v12, "columnName"

    invoke-static {v5, v12}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v8, v5}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static/range {v19 .. v19}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v4, v5, v6}, Ljava/util/TreeMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move/from16 v5, v20

    move-object/from16 v8, v21

    move/from16 v6, v22

    move/from16 v12, v23

    goto :goto_335

    :cond_380
    move/from16 v20, v5

    move/from16 v22, v6

    move-object/from16 v21, v8

    invoke-virtual {v0}, Ljava/util/TreeMap;->values()Ljava/util/Collection;

    move-result-object v0

    const-string v5, "columnsMap.values"

    invoke-static {v0, v5}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v0}, Lx2/l;->w2(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v0

    invoke-virtual {v4}, Ljava/util/TreeMap;->values()Ljava/util/Collection;

    move-result-object v4

    const-string v5, "ordersMap.values"

    invoke-static {v4, v5}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v4}, Lx2/l;->w2(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v4

    new-instance v5, Lh1/d;

    invoke-direct {v5, v9, v10, v0, v4}, Lh1/d;-><init>(Ljava/lang/String;ZLjava/util/List;Ljava/util/List;)V
    :try_end_3a5
    .catchall {:try_start_2ff .. :try_end_3a5} :catchall_35b

    const/4 v0, 0x0

    :try_start_3a6
    invoke-static {v11, v0}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    const/4 v0, 0x0

    goto :goto_3af

    :goto_3ab
    invoke-static {v11, v0}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_3ae
    .catchall {:try_start_3a6 .. :try_end_3ae} :catchall_3c5

    move-object v5, v0

    :goto_3af
    if-nez v5, :cond_3b6

    invoke-static {v3, v0}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    :goto_3b4
    const/4 v5, 0x0

    goto :goto_3dd

    :cond_3b6
    :try_start_3b6
    invoke-virtual {v7, v5}, Ly2/h;->add(Ljava/lang/Object;)Z
    :try_end_3b9
    .catchall {:try_start_3b6 .. :try_end_3b9} :catchall_3c5

    move-object/from16 v0, p1

    move/from16 v4, v18

    move/from16 v5, v20

    move-object/from16 v8, v21

    move/from16 v6, v22

    goto/16 :goto_2c4

    :catchall_3c5
    move-exception v0

    move-object v1, v0

    goto :goto_40f

    :goto_3c8
    :try_start_3c8
    throw v1
    :try_end_3c9
    .catchall {:try_start_3c8 .. :try_end_3c9} :catchall_3c9

    :catchall_3c9
    move-exception v0

    move-object v2, v0

    :try_start_3cb
    invoke-static {v11, v1}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2

    :cond_3cf
    invoke-static {v7}, Ld3/b;->r(Ly2/h;)Ly2/h;

    move-result-object v0
    :try_end_3d3
    .catchall {:try_start_3cb .. :try_end_3d3} :catchall_3c5

    const/4 v4, 0x0

    invoke-static {v3, v4}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    move-object v5, v0

    goto :goto_3dd

    :goto_3d9
    invoke-static {v3, v0}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    goto :goto_3b4

    :goto_3dd
    new-instance v0, Lh1/e;

    invoke-direct {v0, v2, v1, v5}, Lh1/e;-><init>(Ljava/util/Map;Ljava/util/AbstractSet;Ljava/util/AbstractSet;)V

    move-object/from16 v1, v17

    invoke-virtual {v1, v0}, Lh1/e;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-nez v2, :cond_407

    new-instance v2, Landroidx/room/g0;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "shortcuts(com.josski.simpleshortcut.data.Shortcut).\n Expected:\n"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "\n Found:\n"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {v2, v0, v1}, Landroidx/room/g0;-><init>(Ljava/lang/String;Z)V

    return-object v2

    :cond_407
    new-instance v0, Landroidx/room/g0;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-direct {v0, v2, v1}, Landroidx/room/g0;-><init>(Ljava/lang/String;Z)V

    return-object v0

    :goto_40f
    :try_start_40f
    throw v1
    :try_end_410
    .catchall {:try_start_40f .. :try_end_410} :catchall_410

    :catchall_410
    move-exception v0

    move-object v2, v0

    invoke-static {v3, v1}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2

    :goto_416
    :try_start_416
    throw v1
    :try_end_417
    .catchall {:try_start_416 .. :try_end_417} :catchall_417

    :catchall_417
    move-exception v0

    move-object v2, v0

    invoke-static {v3, v1}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2

    :goto_41d
    :try_start_41d
    throw v1
    :try_end_41e
    .catchall {:try_start_41d .. :try_end_41e} :catchall_41e

    :catchall_41e
    move-exception v0

    move-object v2, v0

    invoke-static {v3, v1}, Ld3/b;->I(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    throw v2
.end method

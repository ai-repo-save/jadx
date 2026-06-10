.class Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->getAllShortcuts()Ls3/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/concurrent/Callable<",
        "Ljava/util/List<",
        "Lcom/josski/simpleshortcut/data/Shortcut;",
        ">;>;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

.field final synthetic val$_statement:Landroidx/room/i0;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/i0;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    iput-object p2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;->val$_statement:Landroidx/room/i0;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic call()Ljava/lang/Object;
    .registers 2

    .line 1
    invoke-virtual {p0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;->call()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public call()Ljava/util/List;
    .registers 30
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;"
        }
    .end annotation

    move-object/from16 v1, p0

    .line 2
    iget-object v0, v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v0

    iget-object v2, v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;->val$_statement:Landroidx/room/i0;

    invoke-static {v0, v2}, Ld3/b;->r1(Landroidx/room/e0;Landroidx/room/i0;)Landroid/database/Cursor;

    move-result-object v2

    .line 3
    :try_start_e
    const-string v0, "id"

    invoke-static {v2, v0}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v0

    .line 4
    const-string v3, "label"

    invoke-static {v2, v3}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v3

    .line 5
    const-string v4, "packageName"

    invoke-static {v2, v4}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v4

    .line 6
    const-string v5, "deeplink"

    invoke-static {v2, v5}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v5

    .line 7
    const-string v6, "emoji"

    invoke-static {v2, v6}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v6

    .line 8
    const-string v7, "rank"

    invoke-static {v2, v7}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v7

    .line 9
    const-string v8, "createdAt"

    invoke-static {v2, v8}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v8

    .line 10
    const-string v9, "category"

    invoke-static {v2, v9}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v9

    .line 11
    const-string v10, "isPinned"

    invoke-static {v2, v10}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v10

    .line 12
    const-string v11, "tapCount"

    invoke-static {v2, v11}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v11

    .line 13
    const-string v12, "lastUsedAt"

    invoke-static {v2, v12}, Ld3/b;->k0(Landroid/database/Cursor;Ljava/lang/String;)I

    move-result v12

    .line 14
    new-instance v13, Ljava/util/ArrayList;

    invoke-interface {v2}, Landroid/database/Cursor;->getCount()I

    move-result v14

    invoke-direct {v13, v14}, Ljava/util/ArrayList;-><init>(I)V

    .line 15
    :goto_59
    invoke-interface {v2}, Landroid/database/Cursor;->moveToNext()Z

    move-result v14

    if-eqz v14, :cond_9f

    .line 16
    invoke-interface {v2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v16

    .line 17
    invoke-interface {v2, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v17

    .line 18
    invoke-interface {v2, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v18

    .line 19
    invoke-interface {v2, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v19

    .line 20
    invoke-interface {v2, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v20

    .line 21
    invoke-interface {v2, v7}, Landroid/database/Cursor;->getInt(I)I

    move-result v21

    .line 22
    invoke-interface {v2, v8}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v22

    .line 23
    invoke-interface {v2, v9}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v24

    .line 24
    invoke-interface {v2, v10}, Landroid/database/Cursor;->getInt(I)I

    move-result v14

    if-eqz v14, :cond_89

    const/4 v14, 0x1

    :goto_86
    move/from16 v25, v14

    goto :goto_8b

    :cond_89
    const/4 v14, 0x0

    goto :goto_86

    .line 25
    :goto_8b
    invoke-interface {v2, v11}, Landroid/database/Cursor;->getInt(I)I

    move-result v26

    .line 26
    invoke-interface {v2, v12}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v27

    .line 27
    new-instance v14, Lcom/josski/simpleshortcut/data/Shortcut;

    move-object v15, v14

    invoke-direct/range {v15 .. v28}, Lcom/josski/simpleshortcut/data/Shortcut;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJLjava/lang/String;ZIJ)V

    .line 28
    invoke-virtual {v13, v14}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_9c
    .catchall {:try_start_e .. :try_end_9c} :catchall_9d

    goto :goto_59

    :catchall_9d
    move-exception v0

    goto :goto_a3

    .line 29
    :cond_9f
    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    return-object v13

    :goto_a3
    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .line 30
    throw v0
.end method

.method public finalize()V
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$10;->val$_statement:Landroidx/room/i0;

    invoke-virtual {v0}, Landroidx/room/i0;->i()V

    return-void
.end method

.class Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->getById(Ljava/lang/String;Lz2/e;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/concurrent/Callable<",
        "Lcom/josski/simpleshortcut/data/Shortcut;",
        ">;"
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

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    iput-object p2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;->val$_statement:Landroidx/room/i0;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public call()Lcom/josski/simpleshortcut/data/Shortcut;
    .registers 29

    move-object/from16 v1, p0

    .line 2
    iget-object v0, v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v0

    iget-object v2, v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;->val$_statement:Landroidx/room/i0;

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
    invoke-interface {v2}, Landroid/database/Cursor;->moveToFirst()Z

    move-result v13

    if-eqz v13, :cond_93

    .line 15
    invoke-interface {v2, v0}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v15

    .line 16
    invoke-interface {v2, v3}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v16

    .line 17
    invoke-interface {v2, v4}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v17

    .line 18
    invoke-interface {v2, v5}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v18

    .line 19
    invoke-interface {v2, v6}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v19

    .line 20
    invoke-interface {v2, v7}, Landroid/database/Cursor;->getInt(I)I

    move-result v20

    .line 21
    invoke-interface {v2, v8}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v21

    .line 22
    invoke-interface {v2, v9}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v23

    .line 23
    invoke-interface {v2, v10}, Landroid/database/Cursor;->getInt(I)I

    move-result v0

    if-eqz v0, :cond_80

    const/4 v0, 0x1

    :goto_7d
    move/from16 v24, v0

    goto :goto_82

    :cond_80
    const/4 v0, 0x0

    goto :goto_7d

    .line 24
    :goto_82
    invoke-interface {v2, v11}, Landroid/database/Cursor;->getInt(I)I

    move-result v25

    .line 25
    invoke-interface {v2, v12}, Landroid/database/Cursor;->getLong(I)J

    move-result-wide v26

    .line 26
    new-instance v0, Lcom/josski/simpleshortcut/data/Shortcut;

    move-object v14, v0

    invoke-direct/range {v14 .. v27}, Lcom/josski/simpleshortcut/data/Shortcut;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;IJLjava/lang/String;ZIJ)V
    :try_end_90
    .catchall {:try_start_e .. :try_end_90} :catchall_91

    goto :goto_94

    :catchall_91
    move-exception v0

    goto :goto_9d

    :cond_93
    const/4 v0, 0x0

    .line 27
    :goto_94
    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .line 28
    iget-object v2, v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;->val$_statement:Landroidx/room/i0;

    invoke-virtual {v2}, Landroidx/room/i0;->i()V

    return-object v0

    .line 29
    :goto_9d
    invoke-interface {v2}, Landroid/database/Cursor;->close()V

    .line 30
    iget-object v2, v1, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;->val$_statement:Landroidx/room/i0;

    invoke-virtual {v2}, Landroidx/room/i0;->i()V

    .line 31
    throw v0
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .registers 2

    .line 1
    invoke-virtual {p0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$11;->call()Lcom/josski/simpleshortcut/data/Shortcut;

    move-result-object v0

    return-object v0
.end method

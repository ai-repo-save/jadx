.class Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->getAllCategories()Ls3/e;
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
        "Ljava/lang/String;",
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

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    iput-object p2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;->val$_statement:Landroidx/room/i0;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic call()Ljava/lang/Object;
    .registers 2

    .line 1
    invoke-virtual {p0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;->call()Ljava/util/List;

    move-result-object v0

    return-object v0
.end method

.method public call()Ljava/util/List;
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 2
    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v0

    iget-object v1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;->val$_statement:Landroidx/room/i0;

    invoke-static {v0, v1}, Ld3/b;->r1(Landroidx/room/e0;Landroidx/room/i0;)Landroid/database/Cursor;

    move-result-object v0

    .line 3
    :try_start_c
    new-instance v1, Ljava/util/ArrayList;

    invoke-interface {v0}, Landroid/database/Cursor;->getCount()I

    move-result v2

    invoke-direct {v1, v2}, Ljava/util/ArrayList;-><init>(I)V

    .line 4
    :goto_15
    invoke-interface {v0}, Landroid/database/Cursor;->moveToNext()Z

    move-result v2

    if-eqz v2, :cond_26

    const/4 v2, 0x0

    .line 5
    invoke-interface {v0, v2}, Landroid/database/Cursor;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 6
    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_23
    .catchall {:try_start_c .. :try_end_23} :catchall_24

    goto :goto_15

    :catchall_24
    move-exception v1

    goto :goto_2a

    .line 7
    :cond_26
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    return-object v1

    :goto_2a
    invoke-interface {v0}, Landroid/database/Cursor;->close()V

    .line 8
    throw v1
.end method

.method public finalize()V
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$12;->val$_statement:Landroidx/room/i0;

    invoke-virtual {v0}, Landroidx/room/i0;->i()V

    return-void
.end method

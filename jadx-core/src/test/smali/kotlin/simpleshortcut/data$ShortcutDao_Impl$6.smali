.class Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->delete(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Ljava/util/concurrent/Callable<",
        "Lw2/i;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

.field final synthetic val$shortcut:Lcom/josski/simpleshortcut/data/Shortcut;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Lcom/josski/simpleshortcut/data/Shortcut;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    iput-object p2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->val$shortcut:Lcom/josski/simpleshortcut/data/Shortcut;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic call()Ljava/lang/Object;
    .registers 2

    .line 1
    invoke-virtual {p0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->call()Lw2/i;

    move-result-object v0

    return-object v0
.end method

.method public call()Lw2/i;
    .registers 3

    .line 2
    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/room/e0;->beginTransaction()V

    .line 3
    :try_start_9
    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$200(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/l;

    move-result-object v0

    iget-object v1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->val$shortcut:Lcom/josski/simpleshortcut/data/Shortcut;

    invoke-virtual {v0, v1}, Landroidx/room/l;->handle(Ljava/lang/Object;)I

    .line 4
    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/room/e0;->setTransactionSuccessful()V

    .line 5
    sget-object v0, Lw2/i;->a:Lw2/i;
    :try_end_1f
    .catchall {:try_start_9 .. :try_end_1f} :catchall_29

    .line 6
    iget-object v1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/room/e0;->endTransaction()V

    return-object v0

    :catchall_29
    move-exception v0

    iget-object v1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$6;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/room/e0;->endTransaction()V

    .line 7
    throw v0
.end method

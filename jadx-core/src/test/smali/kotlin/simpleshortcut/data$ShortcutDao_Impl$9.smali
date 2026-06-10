.class Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->incrementTapCount(Ljava/lang/String;JLz2/e;)Ljava/lang/Object;
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

.field final synthetic val$id:Ljava/lang/String;

.field final synthetic val$now:J


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;JLjava/lang/String;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    iput-wide p2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->val$now:J

    iput-object p4, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->val$id:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public bridge synthetic call()Ljava/lang/Object;
    .registers 2

    .line 1
    invoke-virtual {p0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->call()Lw2/i;

    move-result-object v0

    return-object v0
.end method

.method public call()Lw2/i;
    .registers 5

    .line 2
    iget-object v0, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v0}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$400(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/k0;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/room/k0;->acquire()Lj1/h;

    move-result-object v0

    const/4 v1, 0x1

    .line 3
    iget-wide v2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->val$now:J

    invoke-interface {v0, v1, v2, v3}, Lj1/f;->p(IJ)V

    const/4 v1, 0x2

    .line 4
    iget-object v2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->val$id:Ljava/lang/String;

    invoke-interface {v0, v2, v1}, Lj1/f;->h(Ljava/lang/String;I)V

    .line 5
    :try_start_16
    iget-object v1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/room/e0;->beginTransaction()V
    :try_end_1f
    .catchall {:try_start_16 .. :try_end_1f} :catchall_40

    .line 6
    :try_start_1f
    invoke-interface {v0}, Lj1/h;->w()I

    .line 7
    iget-object v1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v1}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/room/e0;->setTransactionSuccessful()V

    .line 8
    sget-object v1, Lw2/i;->a:Lw2/i;
    :try_end_2d
    .catchall {:try_start_1f .. :try_end_2d} :catchall_42

    .line 9
    :try_start_2d
    iget-object v2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v2}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/room/e0;->endTransaction()V
    :try_end_36
    .catchall {:try_start_2d .. :try_end_36} :catchall_40

    .line 10
    iget-object v2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v2}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$400(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/k0;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroidx/room/k0;->release(Lj1/h;)V

    return-object v1

    :catchall_40
    move-exception v1

    goto :goto_4d

    :catchall_42
    move-exception v1

    .line 11
    :try_start_43
    iget-object v2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v2}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$000(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/e0;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/room/e0;->endTransaction()V

    .line 12
    throw v1
    :try_end_4d
    .catchall {:try_start_43 .. :try_end_4d} :catchall_40

    .line 13
    :goto_4d
    iget-object v2, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$9;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-static {v2}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;->access$400(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;)Landroidx/room/k0;

    move-result-object v2

    invoke-virtual {v2, v0}, Landroidx/room/k0;->release(Lj1/h;)V

    .line 14
    throw v1
.end method

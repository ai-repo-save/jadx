.class public final Lcom/josski/simpleshortcut/widget/a;
.super Lb3/h;
.source "SourceFile"

# interfaces
.implements Lg3/p;


# instance fields
.field public d:I

.field public final synthetic e:Landroid/content/Context;

.field public final synthetic f:Ljava/lang/String;

.field public final synthetic g:Landroid/content/BroadcastReceiver$PendingResult;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Landroid/content/BroadcastReceiver$PendingResult;Lz2/e;)V
    .registers 5

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/a;->e:Landroid/content/Context;

    iput-object p2, p0, Lcom/josski/simpleshortcut/widget/a;->f:Ljava/lang/String;

    iput-object p3, p0, Lcom/josski/simpleshortcut/widget/a;->g:Landroid/content/BroadcastReceiver$PendingResult;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p4}, Lb3/h;-><init>(ILz2/e;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lz2/e;)Lz2/e;
    .registers 6

    new-instance p1, Lcom/josski/simpleshortcut/widget/a;

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/a;->f:Ljava/lang/String;

    iget-object v1, p0, Lcom/josski/simpleshortcut/widget/a;->g:Landroid/content/BroadcastReceiver$PendingResult;

    iget-object v2, p0, Lcom/josski/simpleshortcut/widget/a;->e:Landroid/content/Context;

    invoke-direct {p1, v2, v0, v1, p2}, Lcom/josski/simpleshortcut/widget/a;-><init>(Landroid/content/Context;Ljava/lang/String;Landroid/content/BroadcastReceiver$PendingResult;Lz2/e;)V

    return-object p1
.end method

.method public final f(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    check-cast p1, Lp3/v;

    check-cast p2, Lz2/e;

    invoke-virtual {p0, p1, p2}, Lcom/josski/simpleshortcut/widget/a;->create(Ljava/lang/Object;Lz2/e;)Lz2/e;

    move-result-object p1

    check-cast p1, Lcom/josski/simpleshortcut/widget/a;

    sget-object p2, Lw2/i;->a:Lw2/i;

    invoke-virtual {p1, p2}, Lcom/josski/simpleshortcut/widget/a;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 7

    sget-object v0, La3/a;->c:La3/a;

    iget v1, p0, Lcom/josski/simpleshortcut/widget/a;->d:I

    iget-object v2, p0, Lcom/josski/simpleshortcut/widget/a;->g:Landroid/content/BroadcastReceiver$PendingResult;

    iget-object v3, p0, Lcom/josski/simpleshortcut/widget/a;->e:Landroid/content/Context;

    const/4 v4, 0x1

    if-eqz v1, :cond_1b

    if-ne v1, v4, :cond_13

    :try_start_d
    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_10
    .catchall {:try_start_d .. :try_end_10} :catchall_11

    goto :goto_33

    :catchall_11
    move-exception p1

    goto :goto_48

    :cond_13
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_1b
    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V

    :try_start_1e
    sget-object p1, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->Companion:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;

    invoke-virtual {p1, v3}, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;->getDatabase(Landroid/content/Context;)Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    move-result-object p1

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->shortcutDao()Lcom/josski/simpleshortcut/data/ShortcutDao;

    move-result-object p1

    iget-object v1, p0, Lcom/josski/simpleshortcut/widget/a;->f:Ljava/lang/String;

    iput v4, p0, Lcom/josski/simpleshortcut/widget/a;->d:I

    invoke-interface {p1, v1, p0}, Lcom/josski/simpleshortcut/data/ShortcutDao;->getById(Ljava/lang/String;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v0, :cond_33

    return-object v0

    :cond_33
    :goto_33
    check-cast p1, Lcom/josski/simpleshortcut/data/Shortcut;

    if-eqz p1, :cond_42

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getDeeplink()Ljava/lang/String;

    move-result-object p1

    invoke-static {v3, v0, p1}, Ld3/b;->Q0(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_42
    .catchall {:try_start_1e .. :try_end_42} :catchall_11

    :cond_42
    invoke-virtual {v2}, Landroid/content/BroadcastReceiver$PendingResult;->finish()V

    sget-object p1, Lw2/i;->a:Lw2/i;

    return-object p1

    :goto_48
    invoke-virtual {v2}, Landroid/content/BroadcastReceiver$PendingResult;->finish()V

    throw p1
.end method

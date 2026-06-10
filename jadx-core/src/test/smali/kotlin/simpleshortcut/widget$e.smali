.class public final Lcom/josski/simpleshortcut/widget/e;
.super Lb3/h;
.source "SourceFile"

# interfaces
.implements Lg3/p;


# instance fields
.field public d:I

.field public final synthetic e:Lcom/josski/simpleshortcut/data/ShortcutDatabase;

.field public final synthetic f:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/data/ShortcutDatabase;Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Lz2/e;)V
    .registers 4

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/e;->e:Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    iput-object p2, p0, Lcom/josski/simpleshortcut/widget/e;->f:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p3}, Lb3/h;-><init>(ILz2/e;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lz2/e;)Lz2/e;
    .registers 5

    new-instance p1, Lcom/josski/simpleshortcut/widget/e;

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/e;->e:Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    iget-object v1, p0, Lcom/josski/simpleshortcut/widget/e;->f:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;

    invoke-direct {p1, v0, v1, p2}, Lcom/josski/simpleshortcut/widget/e;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDatabase;Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Lz2/e;)V

    return-object p1
.end method

.method public final f(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    check-cast p1, Lp3/v;

    check-cast p2, Lz2/e;

    invoke-virtual {p0, p1, p2}, Lcom/josski/simpleshortcut/widget/e;->create(Ljava/lang/Object;Lz2/e;)Lz2/e;

    move-result-object p1

    check-cast p1, Lcom/josski/simpleshortcut/widget/e;

    sget-object p2, Lw2/i;->a:Lw2/i;

    invoke-virtual {p1, p2}, Lcom/josski/simpleshortcut/widget/e;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 8

    sget-object v0, La3/a;->c:La3/a;

    iget v1, p0, Lcom/josski/simpleshortcut/widget/e;->d:I

    const/4 v2, 0x1

    if-eqz v1, :cond_15

    if-ne v1, v2, :cond_d

    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V

    goto :goto_37

    :cond_d
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_15
    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/josski/simpleshortcut/widget/e;->e:Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->shortcutDao()Lcom/josski/simpleshortcut/data/ShortcutDao;

    move-result-object p1

    invoke-interface {p1}, Lcom/josski/simpleshortcut/data/ShortcutDao;->getAllShortcutsSync()Ljava/util/List;

    move-result-object p1

    sget-object v1, Lp3/e0;->a:Lv3/e;

    sget-object v1, Lu3/p;->a:Lp3/h1;

    new-instance v3, Lcom/josski/simpleshortcut/widget/d;

    iget-object v4, p0, Lcom/josski/simpleshortcut/widget/e;->f:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;

    const/4 v5, 0x0

    invoke-direct {v3, p1, v4, v5}, Lcom/josski/simpleshortcut/widget/d;-><init>(Ljava/util/List;Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Lz2/e;)V

    iput v2, p0, Lcom/josski/simpleshortcut/widget/e;->d:I

    invoke-static {v1, v3, p0}, Ld3/b;->e2(Lp3/s;Lg3/p;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v0, :cond_37

    return-object v0

    :cond_37
    :goto_37
    sget-object p1, Lw2/i;->a:Lw2/i;

    return-object p1
.end method

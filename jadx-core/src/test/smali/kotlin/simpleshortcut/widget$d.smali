.class public final Lcom/josski/simpleshortcut/widget/d;
.super Lb3/h;
.source "SourceFile"

# interfaces
.implements Lg3/p;


# instance fields
.field public final synthetic d:Ljava/util/List;

.field public final synthetic e:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;


# direct methods
.method public constructor <init>(Ljava/util/List;Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Lz2/e;)V
    .registers 4

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/d;->d:Ljava/util/List;

    iput-object p2, p0, Lcom/josski/simpleshortcut/widget/d;->e:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p3}, Lb3/h;-><init>(ILz2/e;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lz2/e;)Lz2/e;
    .registers 5

    new-instance p1, Lcom/josski/simpleshortcut/widget/d;

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/d;->d:Ljava/util/List;

    iget-object v1, p0, Lcom/josski/simpleshortcut/widget/d;->e:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;

    invoke-direct {p1, v0, v1, p2}, Lcom/josski/simpleshortcut/widget/d;-><init>(Ljava/util/List;Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Lz2/e;)V

    return-object p1
.end method

.method public final f(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    check-cast p1, Lp3/v;

    check-cast p2, Lz2/e;

    invoke-virtual {p0, p1, p2}, Lcom/josski/simpleshortcut/widget/d;->create(Ljava/lang/Object;Lz2/e;)Lz2/e;

    move-result-object p1

    check-cast p1, Lcom/josski/simpleshortcut/widget/d;

    sget-object p2, Lw2/i;->a:Lw2/i;

    invoke-virtual {p1, p2}, Lcom/josski/simpleshortcut/widget/d;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 9

    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V

    iget-object p1, p0, Lcom/josski/simpleshortcut/widget/d;->d:Ljava/util/List;

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v0

    sget-object v1, Lw2/i;->a:Lw2/i;

    const/4 v2, 0x1

    iget-object v3, p0, Lcom/josski/simpleshortcut/widget/d;->e:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;

    if-eqz v0, :cond_22

    const p1, 0x7f0f00ca

    invoke-virtual {v3, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    invoke-static {v3, p1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/Toast;->show()V

    invoke-virtual {v3}, Landroid/app/Activity;->finish()V

    return-object v1

    :cond_22
    invoke-static {v3}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->access$getBinding$p(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;)Lv2/b;

    move-result-object v0

    const/4 v4, 0x0

    const-string v5, "binding"

    if-eqz v0, :cond_4f

    new-instance v6, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-direct {v6, v2}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(I)V

    iget-object v0, v0, Lv2/b;->a:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v0, v6}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/k1;)V

    invoke-static {v3}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->access$getBinding$p(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;)Lv2/b;

    move-result-object v0

    if-eqz v0, :cond_4b

    new-instance v4, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;

    new-instance v5, Ly0/r;

    invoke-direct {v5, v2, v3}, Ly0/r;-><init>(ILjava/lang/Object;)V

    invoke-direct {v4, v3, p1, v5}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;-><init>(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Ljava/util/List;Lg3/l;)V

    iget-object p1, v0, Lv2/b;->a:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {p1, v4}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/z0;)V

    return-object v1

    :cond_4b
    invoke-static {v5}, Ld3/b;->Z1(Ljava/lang/String;)V

    throw v4

    :cond_4f
    invoke-static {v5}, Ld3/b;->Z1(Ljava/lang/String;)V

    throw v4
.end method

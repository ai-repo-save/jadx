.class public final Lcom/josski/simpleshortcut/MainActivity;
.super Lg/m;
.source "SourceFile"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0018\u00002\u00020\u0001:\u0001\u0004B\u0007\u00a2\u0006\u0004\u0008\u0002\u0010\u0003\u00a8\u0006\u0005"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/MainActivity;",
        "Lg/m;",
        "<init>",
        "()V",
        "androidx/lifecycle/f1",
        "app_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
.end annotation


# static fields
.field public static final synthetic K:I


# instance fields
.field public C:Lv2/a;

.field public D:Lu2/a0;

.field public E:Landroidx/recyclerview/widget/j0;

.field public F:Ljava/util/List;

.field public G:Z

.field public final H:Landroidx/lifecycle/d1;

.field public final I:Lc/h;

.field public final J:Lc/h;


# direct methods
.method public constructor <init>()V
    .registers 8

    invoke-direct {p0}, Ly0/e0;-><init>()V

    iget-object v0, p0, La/s;->f:Li1/e;

    iget-object v0, v0, Li1/e;->b:Li1/d;

    new-instance v1, Lg/k;

    invoke-direct {v1, p0}, Lg/k;-><init>(Lg/m;)V

    const-string v2, "androidx:appcompat"

    invoke-virtual {v0, v2, v1}, Li1/d;->c(Ljava/lang/String;Li1/c;)V

    new-instance v0, Lg/l;

    invoke-direct {v0, p0}, Lg/l;-><init>(Lg/m;)V

    invoke-virtual {p0, v0}, La/s;->g(Lb/b;)V

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/josski/simpleshortcut/MainActivity;->F:Ljava/util/List;

    new-instance v0, Lu2/v;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1}, Lu2/v;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    new-instance v2, Landroidx/lifecycle/d1;

    const-class v3, Lu2/k0;

    invoke-static {v3}, Lh3/n;->a(Ljava/lang/Class;)Lh3/d;

    move-result-object v3

    new-instance v4, La/q;

    const/4 v5, 0x4

    invoke-direct {v4, p0, v5}, La/q;-><init>(La/s;I)V

    new-instance v5, Ly0/n;

    const/4 v6, 0x0

    invoke-direct {v5, v6, p0, v1}, Ly0/n;-><init>(Ly0/p;Landroid/view/KeyEvent$Callback;I)V

    invoke-direct {v2, v3, v4, v0, v5}, Landroidx/lifecycle/d1;-><init>(Lh3/d;La/q;Lu2/v;Ly0/n;)V

    iput-object v2, p0, Lcom/josski/simpleshortcut/MainActivity;->H:Landroidx/lifecycle/d1;

    new-instance v0, Ld/a;

    invoke-direct {v0}, Ld/a;-><init>()V

    new-instance v2, Lu2/d;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lu2/d;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    invoke-virtual {p0, v2, v0}, La/s;->h(Lu2/d;Ld3/b;)Lc/h;

    move-result-object v0

    iput-object v0, p0, Lcom/josski/simpleshortcut/MainActivity;->I:Lc/h;

    new-instance v0, Ld/b;

    invoke-direct {v0, v3}, Ld/b;-><init>(I)V

    new-instance v2, Lu2/d;

    invoke-direct {v2, p0, v1}, Lu2/d;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    invoke-virtual {p0, v2, v0}, La/s;->h(Lu2/d;Ld3/b;)Lc/h;

    move-result-object v0

    iput-object v0, p0, Lcom/josski/simpleshortcut/MainActivity;->J:Lc/h;

    return-void
.end method

.method public static final m(Lcom/josski/simpleshortcut/MainActivity;Lcom/josski/simpleshortcut/data/Shortcut;)V
    .registers 8

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_9d

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_e

    goto/16 :goto_9d

    :cond_e
    invoke-virtual {p0}, Landroid/app/Activity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {v0}, Lk/x;->e(Landroid/view/LayoutInflater;)Lk/x;

    move-result-object v0

    iget-object v1, v0, Lk/x;->d:Ljava/lang/Object;

    check-cast v1, Lcom/google/android/material/textfield/TextInputEditText;

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getEmoji()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lk/x;->e:Ljava/lang/Object;

    check-cast v1, Lcom/google/android/material/textfield/TextInputEditText;

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getLabel()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lk/x;->f:Ljava/lang/Object;

    check-cast v1, Lcom/google/android/material/textfield/TextInputEditText;

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lk/x;->c:Ljava/lang/Object;

    check-cast v1, Lcom/google/android/material/textfield/TextInputEditText;

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getDeeplink()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lk/x;->b:Ljava/lang/Object;

    check-cast v1, Lcom/google/android/material/textfield/TextInputEditText;

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getCategory()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    new-instance v1, Lc2/b;

    invoke-direct {v1, p0}, Lc2/b;-><init>(Landroid/content/Context;)V

    iget-object v2, v1, Lg/i;->d:Ljava/lang/Object;

    move-object v3, v2

    check-cast v3, Lg/e;

    iget-object v4, v3, Lg/e;->a:Landroid/content/Context;

    const v5, 0x7f0f001d

    invoke-virtual {v4, v5}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v4

    iput-object v4, v3, Lg/e;->d:Ljava/lang/CharSequence;

    iget-object v3, v0, Lk/x;->a:Ljava/lang/Object;

    check-cast v3, Landroid/widget/LinearLayout;

    move-object v4, v2

    check-cast v4, Lg/e;

    iput-object v3, v4, Lg/e;->q:Landroid/view/View;

    move-object v3, v2

    check-cast v3, Lg/e;

    iget-object v4, v3, Lg/e;->a:Landroid/content/Context;

    const v5, 0x7f0f002c

    invoke-virtual {v4, v5}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v4

    iput-object v4, v3, Lg/e;->g:Ljava/lang/CharSequence;

    const/4 v4, 0x0

    iput-object v4, v3, Lg/e;->h:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v1}, Lc2/b;->b()V

    check-cast v2, Lg/e;

    iget-object v3, v2, Lg/e;->a:Landroid/content/Context;

    const v5, 0x7f0f002d

    invoke-virtual {v3, v5}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v3

    iput-object v3, v2, Lg/e;->k:Ljava/lang/CharSequence;

    iput-object v4, v2, Lg/e;->l:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v1}, Lc2/b;->a()Lg/j;

    move-result-object v1

    new-instance v2, Lu2/e;

    invoke-direct {v2, v1, v0, p0, p1}, Lu2/e;-><init>(Lg/j;Lk/x;Lcom/josski/simpleshortcut/MainActivity;Lcom/josski/simpleshortcut/data/Shortcut;)V

    invoke-virtual {v1, v2}, Landroid/app/Dialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    invoke-virtual {v1}, Landroid/app/Dialog;->show()V

    :cond_9d
    :goto_9d
    return-void
.end method


# virtual methods
.method public final n()Lu2/k0;
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/MainActivity;->H:Landroidx/lifecycle/d1;

    invoke-virtual {v0}, Landroidx/lifecycle/d1;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lu2/k0;

    return-object v0
.end method

.method public final o(Landroid/content/Intent;)V
    .registers 5

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_34

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_d

    goto :goto_34

    :cond_d
    const-string v0, "extra_open_add_dialog"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_1d

    invoke-virtual {p1, v0}, Landroid/content/Intent;->removeExtra(Ljava/lang/String;)V

    invoke-virtual {p0}, Lcom/josski/simpleshortcut/MainActivity;->p()V

    return-void

    :cond_1d
    const-string v0, "extra_shortcut_id"

    invoke-virtual {p1, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_26

    return-void

    :cond_26
    invoke-static {p0}, Ld3/b;->t0(Landroidx/lifecycle/v;)Landroidx/lifecycle/q;

    move-result-object v0

    new-instance v1, Lu2/k;

    const/4 v2, 0x0

    invoke-direct {v1, p0, p1, v2}, Lu2/k;-><init>(Lcom/josski/simpleshortcut/MainActivity;Ljava/lang/String;Lz2/e;)V

    const/4 p1, 0x3

    invoke-static {v0, v2, v2, v1, p1}, Ld3/b;->S0(Lp3/v;Lp3/s;Lp3/w;Lg3/p;I)Lp3/m1;

    :cond_34
    :goto_34
    return-void
.end method

.method public final onCreate(Landroid/os/Bundle;)V
    .registers 20

    move-object/from16 v0, p0

    invoke-super/range {p0 .. p1}, Ly0/e0;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual/range {p0 .. p0}, Landroid/app/Activity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v1

    const v2, 0x7f0b001c

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-virtual {v1, v2, v3, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v1

    const v2, 0x7f080066

    invoke-static {v1, v2}, Ld3/b;->b0(Landroid/view/View;I)Landroid/view/View;

    move-result-object v5

    move-object v8, v5

    check-cast v8, Lcom/google/android/material/chip/ChipGroup;

    if-eqz v8, :cond_1d4

    const v2, 0x7f0800a8

    invoke-static {v1, v2}, Ld3/b;->b0(Landroid/view/View;I)Landroid/view/View;

    move-result-object v5

    move-object v9, v5

    check-cast v9, Lcom/google/android/material/textfield/TextInputEditText;

    if-eqz v9, :cond_1d4

    const v2, 0x7f0800ac

    invoke-static {v1, v2}, Ld3/b;->b0(Landroid/view/View;I)Landroid/view/View;

    move-result-object v5

    move-object v10, v5

    check-cast v10, Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    if-eqz v10, :cond_1d4

    const v2, 0x7f080159

    invoke-static {v1, v2}, Ld3/b;->b0(Landroid/view/View;I)Landroid/view/View;

    move-result-object v5

    move-object v11, v5

    check-cast v11, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v11, :cond_1d4

    new-instance v2, Lv2/a;

    check-cast v1, Landroidx/coordinatorlayout/widget/CoordinatorLayout;

    move-object v6, v2

    move-object v7, v1

    invoke-direct/range {v6 .. v11}, Lv2/a;-><init>(Landroidx/coordinatorlayout/widget/CoordinatorLayout;Lcom/google/android/material/chip/ChipGroup;Lcom/google/android/material/textfield/TextInputEditText;Lcom/google/android/material/floatingactionbutton/FloatingActionButton;Landroidx/recyclerview/widget/RecyclerView;)V

    iput-object v2, v0, Lcom/josski/simpleshortcut/MainActivity;->C:Lv2/a;

    invoke-virtual {v0, v1}, Lg/m;->setContentView(Landroid/view/View;)V

    new-instance v1, Lu2/a0;

    new-instance v13, Lu2/s;

    invoke-direct {v13, v0, v4}, Lu2/s;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    new-instance v14, Lu2/s;

    const/4 v2, 0x1

    invoke-direct {v14, v0, v2}, Lu2/s;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    new-instance v15, Lu2/s;

    const/4 v5, 0x2

    invoke-direct {v15, v0, v5}, Lu2/s;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    new-instance v5, Lu2/s;

    const/4 v6, 0x3

    invoke-direct {v5, v0, v6}, Lu2/s;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    new-instance v7, Lu2/s;

    const/4 v8, 0x4

    invoke-direct {v7, v0, v8}, Lu2/s;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    move-object v12, v1

    move-object/from16 v16, v5

    move-object/from16 v17, v7

    invoke-direct/range {v12 .. v17}, Lu2/a0;-><init>(Lu2/s;Lu2/s;Lu2/s;Lu2/s;Lu2/s;)V

    iput-object v1, v0, Lcom/josski/simpleshortcut/MainActivity;->D:Lu2/a0;

    iget-object v1, v0, Lcom/josski/simpleshortcut/MainActivity;->C:Lv2/a;

    const-string v5, "binding"

    if-eqz v1, :cond_1d0

    new-instance v7, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-direct {v7, v2}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(I)V

    iget-object v1, v1, Lv2/a;->d:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v7}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/k1;)V

    iget-object v1, v0, Lcom/josski/simpleshortcut/MainActivity;->C:Lv2/a;

    if-eqz v1, :cond_1cc

    iget-object v7, v0, Lcom/josski/simpleshortcut/MainActivity;->D:Lu2/a0;

    if-eqz v7, :cond_1c6

    iget-object v1, v1, Lv2/a;->d:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v7}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/z0;)V

    new-instance v1, Landroidx/recyclerview/widget/j0;

    new-instance v7, Lu2/b0;

    new-instance v8, Lu2/u;

    invoke-direct {v8, v4, v0}, Lu2/u;-><init>(ILjava/lang/Object;)V

    new-instance v9, Lu2/s;

    const/4 v10, 0x5

    invoke-direct {v9, v0, v10}, Lu2/s;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    new-instance v10, Lu2/v;

    invoke-direct {v10, v0, v4}, Lu2/v;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    invoke-direct {v7, v8, v9, v10}, Lu2/b0;-><init>(Lu2/u;Lu2/s;Lu2/v;)V

    invoke-direct {v1, v7}, Landroidx/recyclerview/widget/j0;-><init>(Lu2/b0;)V

    iput-object v1, v0, Lcom/josski/simpleshortcut/MainActivity;->E:Landroidx/recyclerview/widget/j0;

    iget-object v7, v0, Lcom/josski/simpleshortcut/MainActivity;->C:Lv2/a;

    if-eqz v7, :cond_1c2

    iget-object v8, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v7, v7, Lv2/a;->d:Landroidx/recyclerview/widget/RecyclerView;

    if-ne v8, v7, :cond_be

    goto/16 :goto_179

    :cond_be
    iget-object v9, v1, Landroidx/recyclerview/widget/j0;->A:Landroidx/recyclerview/widget/f0;

    if-eqz v8, :cond_11b

    invoke-virtual {v8, v1}, Landroidx/recyclerview/widget/RecyclerView;->c0(Landroidx/recyclerview/widget/h1;)V

    iget-object v8, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v10, v8, Landroidx/recyclerview/widget/RecyclerView;->s:Ljava/util/ArrayList;

    invoke-virtual {v10, v9}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    iget-object v10, v8, Landroidx/recyclerview/widget/RecyclerView;->t:Landroidx/recyclerview/widget/n1;

    if-ne v10, v9, :cond_d2

    iput-object v3, v8, Landroidx/recyclerview/widget/RecyclerView;->t:Landroidx/recyclerview/widget/n1;

    :cond_d2
    iget-object v8, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v8, v8, Landroidx/recyclerview/widget/RecyclerView;->E:Ljava/util/ArrayList;

    if-nez v8, :cond_d9

    goto :goto_dc

    :cond_d9
    invoke-virtual {v8, v1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    :goto_dc
    iget-object v8, v1, Landroidx/recyclerview/widget/j0;->p:Ljava/util/ArrayList;

    invoke-virtual {v8}, Ljava/util/ArrayList;->size()I

    move-result v10

    sub-int/2addr v10, v2

    :goto_e3
    if-ltz v10, :cond_fc

    invoke-virtual {v8, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroidx/recyclerview/widget/g0;

    iget-object v11, v2, Landroidx/recyclerview/widget/g0;->g:Landroid/animation/ValueAnimator;

    invoke-virtual {v11}, Landroid/animation/ValueAnimator;->cancel()V

    iget-object v11, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v2, v2, Landroidx/recyclerview/widget/g0;->e:Landroidx/recyclerview/widget/b2;

    iget-object v12, v1, Landroidx/recyclerview/widget/j0;->m:Landroidx/recyclerview/widget/i0;

    invoke-virtual {v12, v11, v2}, Landroidx/recyclerview/widget/i0;->a(Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/b2;)V

    add-int/lit8 v10, v10, -0x1

    goto :goto_e3

    :cond_fc
    invoke-virtual {v8}, Ljava/util/ArrayList;->clear()V

    iput-object v3, v1, Landroidx/recyclerview/widget/j0;->w:Landroid/view/View;

    const/4 v2, -0x1

    iput v2, v1, Landroidx/recyclerview/widget/j0;->x:I

    iget-object v2, v1, Landroidx/recyclerview/widget/j0;->t:Landroid/view/VelocityTracker;

    if-eqz v2, :cond_10d

    invoke-virtual {v2}, Landroid/view/VelocityTracker;->recycle()V

    iput-object v3, v1, Landroidx/recyclerview/widget/j0;->t:Landroid/view/VelocityTracker;

    :cond_10d
    iget-object v2, v1, Landroidx/recyclerview/widget/j0;->z:Landroidx/recyclerview/widget/h0;

    if-eqz v2, :cond_115

    iput-boolean v4, v2, Landroidx/recyclerview/widget/h0;->a:Z

    iput-object v3, v1, Landroidx/recyclerview/widget/j0;->z:Landroidx/recyclerview/widget/h0;

    :cond_115
    iget-object v2, v1, Landroidx/recyclerview/widget/j0;->y:Lg/n0;

    if-eqz v2, :cond_11b

    iput-object v3, v1, Landroidx/recyclerview/widget/j0;->y:Lg/n0;

    :cond_11b
    iput-object v7, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v7, :cond_179

    invoke-virtual {v7}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const v7, 0x7f06009c

    invoke-virtual {v2, v7}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v7

    iput v7, v1, Landroidx/recyclerview/widget/j0;->f:F

    const v7, 0x7f06009b

    invoke-virtual {v2, v7}, Landroid/content/res/Resources;->getDimension(I)F

    move-result v2

    iput v2, v1, Landroidx/recyclerview/widget/j0;->g:F

    iget-object v2, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v2}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/view/ViewConfiguration;->get(Landroid/content/Context;)Landroid/view/ViewConfiguration;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/ViewConfiguration;->getScaledTouchSlop()I

    move-result v2

    iput v2, v1, Landroidx/recyclerview/widget/j0;->q:I

    iget-object v2, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v2, v1}, Landroidx/recyclerview/widget/RecyclerView;->i(Landroidx/recyclerview/widget/h1;)V

    iget-object v2, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v2, v2, Landroidx/recyclerview/widget/RecyclerView;->s:Ljava/util/ArrayList;

    invoke-virtual {v2, v9}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    iget-object v2, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v7, v2, Landroidx/recyclerview/widget/RecyclerView;->E:Ljava/util/ArrayList;

    if-nez v7, :cond_15e

    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    iput-object v7, v2, Landroidx/recyclerview/widget/RecyclerView;->E:Ljava/util/ArrayList;

    :cond_15e
    iget-object v2, v2, Landroidx/recyclerview/widget/RecyclerView;->E:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v2, Landroidx/recyclerview/widget/h0;

    invoke-direct {v2, v1}, Landroidx/recyclerview/widget/h0;-><init>(Landroidx/recyclerview/widget/j0;)V

    iput-object v2, v1, Landroidx/recyclerview/widget/j0;->z:Landroidx/recyclerview/widget/h0;

    new-instance v2, Lg/n0;

    iget-object v7, v1, Landroidx/recyclerview/widget/j0;->r:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v7}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v7

    iget-object v8, v1, Landroidx/recyclerview/widget/j0;->z:Landroidx/recyclerview/widget/h0;

    invoke-direct {v2, v7, v8, v4}, Lg/n0;-><init>(Landroid/content/Context;Landroidx/recyclerview/widget/h0;I)V

    iput-object v2, v1, Landroidx/recyclerview/widget/j0;->y:Lg/n0;

    :cond_179
    :goto_179
    iget-object v1, v0, Lcom/josski/simpleshortcut/MainActivity;->C:Lv2/a;

    if-eqz v1, :cond_1be

    new-instance v2, Lu2/c;

    invoke-direct {v2, v0, v4}, Lu2/c;-><init>(Lcom/josski/simpleshortcut/MainActivity;I)V

    iget-object v1, v1, Lv2/a;->c:Lcom/google/android/material/floatingactionbutton/FloatingActionButton;

    invoke-virtual {v1, v2}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, v0, Lcom/josski/simpleshortcut/MainActivity;->C:Lv2/a;

    if-eqz v1, :cond_1ba

    new-instance v2, Lu2/m;

    invoke-direct {v2, v0}, Lu2/m;-><init>(Lcom/josski/simpleshortcut/MainActivity;)V

    iget-object v1, v1, Lv2/a;->b:Lcom/google/android/material/textfield/TextInputEditText;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->addTextChangedListener(Landroid/text/TextWatcher;)V

    invoke-static/range {p0 .. p0}, Ld3/b;->t0(Landroidx/lifecycle/v;)Landroidx/lifecycle/q;

    move-result-object v1

    new-instance v2, Lu2/p;

    invoke-direct {v2, v0, v3}, Lu2/p;-><init>(Lcom/josski/simpleshortcut/MainActivity;Lz2/e;)V

    invoke-static {v1, v3, v3, v2, v6}, Ld3/b;->S0(Lp3/v;Lp3/s;Lp3/w;Lg3/p;I)Lp3/m1;

    invoke-static/range {p0 .. p0}, Ld3/b;->t0(Landroidx/lifecycle/v;)Landroidx/lifecycle/q;

    move-result-object v1

    new-instance v2, Lu2/r;

    invoke-direct {v2, v0, v3}, Lu2/r;-><init>(Lcom/josski/simpleshortcut/MainActivity;Lz2/e;)V

    invoke-static {v1, v3, v3, v2, v6}, Ld3/b;->S0(Lp3/v;Lp3/s;Lp3/w;Lg3/p;I)Lp3/m1;

    invoke-virtual/range {p0 .. p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v1

    const-string v2, "getIntent(...)"

    invoke-static {v1, v2}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/josski/simpleshortcut/MainActivity;->o(Landroid/content/Intent;)V

    return-void

    :cond_1ba
    invoke-static {v5}, Ld3/b;->Z1(Ljava/lang/String;)V

    throw v3

    :cond_1be
    invoke-static {v5}, Ld3/b;->Z1(Ljava/lang/String;)V

    throw v3

    :cond_1c2
    invoke-static {v5}, Ld3/b;->Z1(Ljava/lang/String;)V

    throw v3

    :cond_1c6
    const-string v1, "adapter"

    invoke-static {v1}, Ld3/b;->Z1(Ljava/lang/String;)V

    throw v3

    :cond_1cc
    invoke-static {v5}, Ld3/b;->Z1(Ljava/lang/String;)V

    throw v3

    :cond_1d0
    invoke-static {v5}, Ld3/b;->Z1(Ljava/lang/String;)V

    throw v3

    :cond_1d4
    invoke-virtual {v1}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/NullPointerException;

    const-string v3, "Missing required view with ID: "

    invoke-virtual {v3, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public final onCreateOptionsMenu(Landroid/view/Menu;)Z
    .registers 7

    const-string v0, "menu"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v0, 0x63

    const v1, 0x7f0f0071

    const/4 v2, 0x0

    invoke-interface {p1, v2, v0, v2, v1}, Landroid/view/Menu;->add(IIII)Landroid/view/MenuItem;

    const v0, 0x7f0f006e

    const/16 v1, 0x64

    const/4 v3, 0x1

    invoke-interface {p1, v2, v1, v3, v0}, Landroid/view/Menu;->add(IIII)Landroid/view/MenuItem;

    const/4 v0, 0x2

    const v1, 0x7f0f006f

    const/16 v4, 0x65

    invoke-interface {p1, v2, v4, v0, v1}, Landroid/view/Menu;->add(IIII)Landroid/view/MenuItem;

    return v3
.end method

.method public final onNewIntent(Landroid/content/Intent;)V
    .registers 3

    const-string v0, "intent"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-super {p0, p1}, La/s;->onNewIntent(Landroid/content/Intent;)V

    invoke-virtual {p0, p1}, Lcom/josski/simpleshortcut/MainActivity;->o(Landroid/content/Intent;)V

    return-void
.end method

.method public final onOptionsItemSelected(Landroid/view/MenuItem;)Z
    .registers 9

    const-string v0, "item"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {p1}, Landroid/view/MenuItem;->getItemId()I

    move-result v0

    const/4 v1, 0x1

    packed-switch v0, :pswitch_data_92

    invoke-super {p0, p1}, Landroid/app/Activity;->onOptionsItemSelected(Landroid/view/MenuItem;)Z

    move-result v1

    goto/16 :goto_90

    :pswitch_13
    const-string p1, "application/json"

    filled-new-array {p1}, [Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/josski/simpleshortcut/MainActivity;->J:Lc/h;

    invoke-virtual {v0, p1}, Ld3/b;->R0(Ljava/io/Serializable;)V

    goto :goto_90

    :pswitch_1f
    iget-object p1, p0, Lcom/josski/simpleshortcut/MainActivity;->I:Lc/h;

    const-string v0, "simpleshortcut_backup.json"

    invoke-virtual {p1, v0}, Ld3/b;->R0(Ljava/io/Serializable;)V

    goto :goto_90

    :pswitch_27
    const p1, 0x7f0f00c6

    invoke-virtual {p0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object p1

    const v0, 0x7f0f00c5

    invoke-virtual {p0, v0}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    const v2, 0x7f0f00c4

    invoke-virtual {p0, v2}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v2

    const v3, 0x7f0f00c7

    invoke-virtual {p0, v3}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v3

    const v4, 0x7f0f00c3

    invoke-virtual {p0, v4}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v4

    filled-new-array {p1, v0, v2, v3, v4}, [Ljava/lang/String;

    move-result-object p1

    sget-object v0, Lu2/c0;->e:Lc3/a;

    invoke-virtual {p0}, Lcom/josski/simpleshortcut/MainActivity;->n()Lu2/k0;

    move-result-object v2

    iget-object v2, v2, Lu2/k0;->g:Ls3/q0;

    invoke-virtual {v2}, Ls3/q0;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lu2/c0;

    invoke-virtual {v0, v2}, Lc3/a;->indexOf(Ljava/lang/Object;)I

    move-result v0

    new-instance v2, Lc2/b;

    invoke-direct {v2, p0}, Lc2/b;-><init>(Landroid/content/Context;)V

    iget-object v3, v2, Lg/i;->d:Ljava/lang/Object;

    move-object v4, v3

    check-cast v4, Lg/e;

    iget-object v5, v4, Lg/e;->a:Landroid/content/Context;

    const v6, 0x7f0f0071

    invoke-virtual {v5, v6}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v5

    iput-object v5, v4, Lg/e;->d:Ljava/lang/CharSequence;

    check-cast p1, [Ljava/lang/CharSequence;

    new-instance v4, Lu2/a;

    invoke-direct {v4, p0}, Lu2/a;-><init>(Lcom/josski/simpleshortcut/MainActivity;)V

    check-cast v3, Lg/e;

    iput-object p1, v3, Lg/e;->n:[Ljava/lang/CharSequence;

    iput-object v4, v3, Lg/e;->p:Landroid/content/DialogInterface$OnClickListener;

    iput v0, v3, Lg/e;->s:I

    iput-boolean v1, v3, Lg/e;->r:Z

    invoke-virtual {v2}, Lc2/b;->b()V

    invoke-virtual {v2}, Lc2/b;->a()Lg/j;

    move-result-object p1

    invoke-virtual {p1}, Landroid/app/Dialog;->show()V

    :goto_90
    return v1

    nop

    :pswitch_data_92
    .packed-switch 0x63
        :pswitch_27
        :pswitch_1f
        :pswitch_13
    .end packed-switch
.end method

.method public final p()V
    .registers 7

    invoke-virtual {p0}, Landroid/app/Activity;->isFinishing()Z

    move-result v0

    if-nez v0, :cond_65

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-eqz v0, :cond_d

    goto :goto_65

    :cond_d
    invoke-virtual {p0}, Landroid/app/Activity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {v0}, Lk/x;->e(Landroid/view/LayoutInflater;)Lk/x;

    move-result-object v0

    new-instance v1, Lc2/b;

    invoke-direct {v1, p0}, Lc2/b;-><init>(Landroid/content/Context;)V

    iget-object v2, v1, Lg/i;->d:Ljava/lang/Object;

    move-object v3, v2

    check-cast v3, Lg/e;

    iget-object v4, v3, Lg/e;->a:Landroid/content/Context;

    const v5, 0x7f0f001b

    invoke-virtual {v4, v5}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v4

    iput-object v4, v3, Lg/e;->d:Ljava/lang/CharSequence;

    iget-object v3, v0, Lk/x;->a:Ljava/lang/Object;

    check-cast v3, Landroid/widget/LinearLayout;

    move-object v4, v2

    check-cast v4, Lg/e;

    iput-object v3, v4, Lg/e;->q:Landroid/view/View;

    move-object v3, v2

    check-cast v3, Lg/e;

    iget-object v4, v3, Lg/e;->a:Landroid/content/Context;

    const v5, 0x7f0f002c

    invoke-virtual {v4, v5}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v4

    iput-object v4, v3, Lg/e;->g:Ljava/lang/CharSequence;

    const/4 v4, 0x0

    iput-object v4, v3, Lg/e;->h:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v1}, Lc2/b;->b()V

    check-cast v2, Lg/e;

    iget-object v3, v2, Lg/e;->a:Landroid/content/Context;

    const v5, 0x7f0f002d

    invoke-virtual {v3, v5}, Landroid/content/Context;->getText(I)Ljava/lang/CharSequence;

    move-result-object v3

    iput-object v3, v2, Lg/e;->k:Ljava/lang/CharSequence;

    iput-object v4, v2, Lg/e;->l:Landroid/content/DialogInterface$OnClickListener;

    invoke-virtual {v1}, Lc2/b;->a()Lg/j;

    move-result-object v1

    new-instance v2, Lu2/b;

    invoke-direct {v2, v1, v0, p0}, Lu2/b;-><init>(Lg/j;Lk/x;Lcom/josski/simpleshortcut/MainActivity;)V

    invoke-virtual {v1, v2}, Landroid/app/Dialog;->setOnShowListener(Landroid/content/DialogInterface$OnShowListener;)V

    invoke-virtual {v1}, Landroid/app/Dialog;->show()V

    :cond_65
    :goto_65
    return-void
.end method

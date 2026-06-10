.class public final Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;
.super Landroidx/recyclerview/widget/z0;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "ShortcutPickerAdapter"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/z0;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000:\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0007\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\u0008\u0086\u0004\u0018\u00002\u0010\u0012\u000c\u0012\n0\u0002R\u00060\u0000R\u00020\u00030\u0001:\u0001\u001aB)\u0012\u000c\u0010\u0013\u001a\u0008\u0012\u0004\u0012\u00020\u00120\u0011\u0012\u0012\u0010\u0016\u001a\u000e\u0012\u0004\u0012\u00020\u0012\u0012\u0004\u0012\u00020\u000e0\u0015\u00a2\u0006\u0004\u0008\u0018\u0010\u0019J\'\u0010\u0008\u001a\n0\u0002R\u00060\u0000R\u00020\u00032\u0006\u0010\u0005\u001a\u00020\u00042\u0006\u0010\u0007\u001a\u00020\u0006H\u0016\u00a2\u0006\u0004\u0008\u0008\u0010\tJ\u000f\u0010\n\u001a\u00020\u0006H\u0016\u00a2\u0006\u0004\u0008\n\u0010\u000bJ\'\u0010\u000f\u001a\u00020\u000e2\u000e\u0010\u000c\u001a\n0\u0002R\u00060\u0000R\u00020\u00032\u0006\u0010\r\u001a\u00020\u0006H\u0016\u00a2\u0006\u0004\u0008\u000f\u0010\u0010R\u001a\u0010\u0013\u001a\u0008\u0012\u0004\u0012\u00020\u00120\u00118\u0002X\u0082\u0004\u00a2\u0006\u0006\n\u0004\u0008\u0013\u0010\u0014R \u0010\u0016\u001a\u000e\u0012\u0004\u0012\u00020\u0012\u0012\u0004\u0012\u00020\u000e0\u00158\u0002X\u0082\u0004\u00a2\u0006\u0006\n\u0004\u0008\u0016\u0010\u0017\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;",
        "Landroidx/recyclerview/widget/z0;",
        "Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;",
        "Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;",
        "Landroid/view/ViewGroup;",
        "parent",
        "",
        "viewType",
        "onCreateViewHolder",
        "(Landroid/view/ViewGroup;I)Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;",
        "getItemCount",
        "()I",
        "holder",
        "position",
        "Lw2/i;",
        "onBindViewHolder",
        "(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;I)V",
        "",
        "Lcom/josski/simpleshortcut/data/Shortcut;",
        "items",
        "Ljava/util/List;",
        "Lkotlin/Function1;",
        "onPick",
        "Lg3/l;",
        "<init>",
        "(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Ljava/util/List;Lg3/l;)V",
        "VH",
        "app_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
.end annotation


# instance fields
.field private final items:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;"
        }
    .end annotation
.end field

.field private final onPick:Lg3/l;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lg3/l;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Ljava/util/List;Lg3/l;)V
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;",
            "Lg3/l;",
            ")V"
        }
    .end annotation

    const-string v0, "items"

    invoke-static {p2, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onPick"

    invoke-static {p3, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->this$0:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;

    invoke-direct {p0}, Landroidx/recyclerview/widget/z0;-><init>()V

    iput-object p2, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->items:Ljava/util/List;

    iput-object p3, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->onPick:Lg3/l;

    return-void
.end method

.method public static synthetic a(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;Lcom/josski/simpleshortcut/data/Shortcut;Landroid/view/View;)V
    .registers 3

    invoke-static {p0, p1, p2}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->onBindViewHolder$lambda$1(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;Lcom/josski/simpleshortcut/data/Shortcut;Landroid/view/View;)V

    return-void
.end method

.method private static final onBindViewHolder$lambda$1(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;Lcom/josski/simpleshortcut/data/Shortcut;Landroid/view/View;)V
    .registers 3

    const-string p2, "this$0"

    invoke-static {p0, p2}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string p2, "$item"

    invoke-static {p1, p2}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object p0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->onPick:Lg3/l;

    invoke-interface {p0, p1}, Lg3/l;->i(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public getItemCount()I
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->items:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public bridge synthetic onBindViewHolder(Landroidx/recyclerview/widget/b2;I)V
    .registers 3

    .line 1
    check-cast p1, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;

    invoke-virtual {p0, p1, p2}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->onBindViewHolder(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;I)V

    return-void
.end method

.method public onBindViewHolder(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;I)V
    .registers 6

    const-string v0, "holder"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    .line 2
    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->items:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lcom/josski/simpleshortcut/data/Shortcut;

    .line 3
    invoke-virtual {p1}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->getEmoji()Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getEmoji()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 4
    invoke-virtual {p1}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->getLabel()Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getLabel()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 5
    invoke-virtual {p1}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->getPkg()Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lo3/g;->p2(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_35

    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getDeeplink()Ljava/lang/String;

    move-result-object v1

    :cond_35
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 6
    iget-object p1, p1, Landroidx/recyclerview/widget/b2;->itemView:Landroid/view/View;

    new-instance v0, Lu2/h;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1, p2}, Lu2/h;-><init>(Ljava/lang/Object;ILjava/lang/Object;)V

    invoke-virtual {p1, v0}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method public bridge synthetic onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/b2;
    .registers 3

    .line 1
    invoke-virtual {p0, p1, p2}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;->onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;

    move-result-object p1

    return-object p1
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;
    .registers 5

    const-string p2, "parent"

    invoke-static {p1, p2}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    .line 2
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p2

    invoke-static {p2}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p2

    const v0, 0x7f0b0032

    const/4 v1, 0x0

    .line 3
    invoke-virtual {p2, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    .line 4
    new-instance p2, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;

    invoke-static {p1}, Ld3/b;->A(Ljava/lang/Object;)V

    invoke-direct {p2, p0, p1}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;-><init>(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;Landroid/view/View;)V

    return-object p2
.end method

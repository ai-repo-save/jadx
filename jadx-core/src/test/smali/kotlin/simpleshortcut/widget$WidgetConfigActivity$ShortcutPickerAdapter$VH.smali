.class public final Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;
.super Landroidx/recyclerview/widget/b2;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x11
    name = "VH"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0008\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008\u0086\u0004\u0018\u00002\u00020\u0001B\u000f\u0012\u0006\u0010\u000c\u001a\u00020\u000b\u00a2\u0006\u0004\u0008\r\u0010\u000eR\u0017\u0010\u0003\u001a\u00020\u00028\u0006\u00a2\u0006\u000c\n\u0004\u0008\u0003\u0010\u0004\u001a\u0004\u0008\u0005\u0010\u0006R\u0017\u0010\u0007\u001a\u00020\u00028\u0006\u00a2\u0006\u000c\n\u0004\u0008\u0007\u0010\u0004\u001a\u0004\u0008\u0008\u0010\u0006R\u0017\u0010\t\u001a\u00020\u00028\u0006\u00a2\u0006\u000c\n\u0004\u0008\t\u0010\u0004\u001a\u0004\u0008\n\u0010\u0006\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;",
        "Landroidx/recyclerview/widget/b2;",
        "Landroid/widget/TextView;",
        "emoji",
        "Landroid/widget/TextView;",
        "getEmoji",
        "()Landroid/widget/TextView;",
        "label",
        "getLabel",
        "pkg",
        "getPkg",
        "Landroid/view/View;",
        "view",
        "<init>",
        "(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;Landroid/view/View;)V",
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
.field private final emoji:Landroid/widget/TextView;

.field private final label:Landroid/widget/TextView;

.field private final pkg:Landroid/widget/TextView;

.field final synthetic this$0:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;Landroid/view/View;)V
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/view/View;",
            ")V"
        }
    .end annotation

    const-string v0, "view"

    invoke-static {p2, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->this$0:Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;

    invoke-direct {p0, p2}, Landroidx/recyclerview/widget/b2;-><init>(Landroid/view/View;)V

    const p1, 0x7f08014c

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    const-string v0, "findViewById(...)"

    invoke-static {p1, v0}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->emoji:Landroid/widget/TextView;

    const p1, 0x7f08014d

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-static {p1, v0}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->label:Landroid/widget/TextView;

    const p1, 0x7f08014e

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    invoke-static {p1, v0}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->pkg:Landroid/widget/TextView;

    return-void
.end method


# virtual methods
.method public final getEmoji()Landroid/widget/TextView;
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->emoji:Landroid/widget/TextView;

    return-object v0
.end method

.method public final getLabel()Landroid/widget/TextView;
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->label:Landroid/widget/TextView;

    return-object v0
.end method

.method public final getPkg()Landroid/widget/TextView;
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter$VH;->pkg:Landroid/widget/TextView;

    return-object v0
.end method

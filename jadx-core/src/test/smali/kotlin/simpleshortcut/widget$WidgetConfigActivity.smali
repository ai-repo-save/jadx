.class public final Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;
.super Landroid/app/Activity;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/josski/simpleshortcut/widget/WidgetConfigActivity$ShortcutPickerAdapter;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0008\n\u0002\u0008\u0006\u0018\u00002\u00020\u0001:\u0001\u0013B\u0007\u00a2\u0006\u0004\u0008\u0011\u0010\u0012J\u0017\u0010\u0005\u001a\u00020\u00042\u0006\u0010\u0003\u001a\u00020\u0002H\u0002\u00a2\u0006\u0004\u0008\u0005\u0010\u0006J\u0019\u0010\t\u001a\u00020\u00042\u0008\u0010\u0008\u001a\u0004\u0018\u00010\u0007H\u0014\u00a2\u0006\u0004\u0008\t\u0010\nR\u0016\u0010\u000c\u001a\u00020\u000b8\u0002@\u0002X\u0082.\u00a2\u0006\u0006\n\u0004\u0008\u000c\u0010\rR\u0016\u0010\u000f\u001a\u00020\u000e8\u0002@\u0002X\u0082\u000e\u00a2\u0006\u0006\n\u0004\u0008\u000f\u0010\u0010\u00a8\u0006\u0014"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;",
        "Landroid/app/Activity;",
        "Lcom/josski/simpleshortcut/data/Shortcut;",
        "shortcut",
        "Lw2/i;",
        "onShortcutPicked",
        "(Lcom/josski/simpleshortcut/data/Shortcut;)V",
        "Landroid/os/Bundle;",
        "savedInstanceState",
        "onCreate",
        "(Landroid/os/Bundle;)V",
        "Lv2/b;",
        "binding",
        "Lv2/b;",
        "",
        "appWidgetId",
        "I",
        "<init>",
        "()V",
        "ShortcutPickerAdapter",
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
.field private appWidgetId:I

.field private binding:Lv2/b;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method public static final synthetic access$getBinding$p(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;)Lv2/b;
    .registers 1

    iget-object p0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->binding:Lv2/b;

    return-object p0
.end method

.method public static final synthetic access$onShortcutPicked(Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Lcom/josski/simpleshortcut/data/Shortcut;)V
    .registers 2

    invoke-direct {p0, p1}, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->onShortcutPicked(Lcom/josski/simpleshortcut/data/Shortcut;)V

    return-void
.end method

.method private final onShortcutPicked(Lcom/josski/simpleshortcut/data/Shortcut;)V
    .registers 4

    sget-object v0, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;->Companion:Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;

    iget v1, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->appWidgetId:I

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getId()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p0, v1, p1}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;->saveShortcutForWidget(Landroid/content/Context;ILjava/lang/String;)V

    invoke-static {p0}, Landroid/appwidget/AppWidgetManager;->getInstance(Landroid/content/Context;)Landroid/appwidget/AppWidgetManager;

    move-result-object p1

    invoke-static {p1}, Ld3/b;->A(Ljava/lang/Object;)V

    iget v1, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->appWidgetId:I

    invoke-virtual {v0, p0, p1, v1}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;->updateWidget(Landroid/content/Context;Landroid/appwidget/AppWidgetManager;I)V

    new-instance p1, Landroid/content/Intent;

    invoke-direct {p1}, Landroid/content/Intent;-><init>()V

    const-string v0, "appWidgetId"

    iget v1, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->appWidgetId:I

    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/4 v0, -0x1

    invoke-virtual {p0, v0, p1}, Landroid/app/Activity;->setResult(ILandroid/content/Intent;)V

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void
.end method


# virtual methods
.method public onCreate(Landroid/os/Bundle;)V
    .registers 6

    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Landroid/app/Activity;->setResult(I)V

    invoke-virtual {p0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    if-eqz v0, :cond_1a

    invoke-virtual {v0}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v0

    if-eqz v0, :cond_1a

    const-string v1, "appWidgetId"

    invoke-virtual {v0, v1, p1}, Landroid/os/BaseBundle;->getInt(Ljava/lang/String;I)I

    move-result v0

    goto :goto_1b

    :cond_1a
    move v0, p1

    :goto_1b
    iput v0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->appWidgetId:I

    if-nez v0, :cond_23

    invoke-virtual {p0}, Landroid/app/Activity;->finish()V

    return-void

    :cond_23
    invoke-virtual {p0}, Landroid/app/Activity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    const v1, 0x7f0b001d

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, p1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object p1

    const v0, 0x7f08006f

    invoke-static {p1, v0}, Ld3/b;->b0(Landroid/view/View;I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView;

    if-eqz v1, :cond_67

    const v0, 0x7f080070

    invoke-static {p1, v0}, Ld3/b;->b0(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    if-eqz v3, :cond_67

    new-instance v0, Lv2/b;

    check-cast p1, Landroid/widget/LinearLayout;

    invoke-direct {v0, p1, v1}, Lv2/b;-><init>(Landroid/widget/LinearLayout;Landroidx/recyclerview/widget/RecyclerView;)V

    iput-object v0, p0, Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;->binding:Lv2/b;

    invoke-virtual {p0, p1}, Landroid/app/Activity;->setContentView(Landroid/view/View;)V

    sget-object p1, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->Companion:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;

    invoke-virtual {p1, p0}, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;->getDatabase(Landroid/content/Context;)Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    move-result-object p1

    sget-object v0, Lp3/e0;->b:Lv3/d;

    invoke-static {v0}, Ld3/b;->h(Lz2/h;)Lu3/e;

    move-result-object v0

    new-instance v1, Lcom/josski/simpleshortcut/widget/e;

    invoke-direct {v1, p1, p0, v2}, Lcom/josski/simpleshortcut/widget/e;-><init>(Lcom/josski/simpleshortcut/data/ShortcutDatabase;Lcom/josski/simpleshortcut/widget/WidgetConfigActivity;Lz2/e;)V

    const/4 p1, 0x3

    invoke-static {v0, v2, v2, v1, p1}, Ld3/b;->S0(Lp3/v;Lp3/s;Lp3/w;Lg3/p;I)Lp3/m1;

    return-void

    :cond_67
    invoke-virtual {p1}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    move-result-object p1

    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Missing required view with ID: "

    invoke-virtual {v1, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-direct {v0, p1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.class public final Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;
.super Landroid/appwidget/AppWidgetProvider;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0015\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u0007\u0018\u0000 \u00132\u00020\u0001:\u0001\u0013B\u0007\u00a2\u0006\u0004\u0008\u0011\u0010\u0012J\'\u0010\t\u001a\u00020\u00082\u0006\u0010\u0003\u001a\u00020\u00022\u0006\u0010\u0005\u001a\u00020\u00042\u0006\u0010\u0007\u001a\u00020\u0006H\u0016\u00a2\u0006\u0004\u0008\t\u0010\nJ\u001f\u0010\u000b\u001a\u00020\u00082\u0006\u0010\u0003\u001a\u00020\u00022\u0006\u0010\u0007\u001a\u00020\u0006H\u0016\u00a2\u0006\u0004\u0008\u000b\u0010\u000cJ\u001f\u0010\u000f\u001a\u00020\u00082\u0006\u0010\u0003\u001a\u00020\u00022\u0006\u0010\u000e\u001a\u00020\rH\u0016\u00a2\u0006\u0004\u0008\u000f\u0010\u0010\u00a8\u0006\u0014"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;",
        "Landroid/appwidget/AppWidgetProvider;",
        "Landroid/content/Context;",
        "context",
        "Landroid/appwidget/AppWidgetManager;",
        "appWidgetManager",
        "",
        "appWidgetIds",
        "Lw2/i;",
        "onUpdate",
        "(Landroid/content/Context;Landroid/appwidget/AppWidgetManager;[I)V",
        "onDeleted",
        "(Landroid/content/Context;[I)V",
        "Landroid/content/Intent;",
        "intent",
        "onReceive",
        "(Landroid/content/Context;Landroid/content/Intent;)V",
        "<init>",
        "()V",
        "Companion",
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
.field private static final ACTION_SINGLE_CLICK:Ljava/lang/String; = "com.josski.simpleshortcut.ACTION_SINGLE_CLICK"

.field public static final Companion:Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;

.field private static final EXTRA_SHORTCUT_ID:Ljava/lang/String; = "extra_single_shortcut_id"

.field private static final PREFS_NAME:Ljava/lang/String; = "single_widget_prefs"


# direct methods
.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;-><init>(Lh3/f;)V

    sput-object v0, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;->Companion:Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/appwidget/AppWidgetProvider;-><init>()V

    return-void
.end method


# virtual methods
.method public onDeleted(Landroid/content/Context;[I)V
    .registers 8

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "appWidgetIds"

    invoke-static {p2, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "single_widget_prefs"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    array-length v0, p2

    :goto_12
    if-ge v1, v0, :cond_2a

    aget v2, p2, v1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    sget-object v4, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;->Companion:Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;

    invoke-virtual {v4, v2}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;->prefKey(I)Ljava/lang/String;

    move-result-object v2

    invoke-interface {v3, v2}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v2

    invoke-interface {v2}, Landroid/content/SharedPreferences$Editor;->apply()V

    add-int/lit8 v1, v1, 0x1

    goto :goto_12

    :cond_2a
    return-void
.end method

.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .registers 7

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "intent"

    invoke-static {p2, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-super {p0, p1, p2}, Landroid/appwidget/AppWidgetProvider;->onReceive(Landroid/content/Context;Landroid/content/Intent;)V

    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    const-string v1, "com.josski.simpleshortcut.ACTION_SINGLE_CLICK"

    invoke-static {v0, v1}, Ld3/b;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_36

    const-string v0, "extra_single_shortcut_id"

    invoke-virtual {p2, v0}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    if-nez p2, :cond_22

    return-void

    :cond_22
    invoke-virtual {p0}, Landroid/content/BroadcastReceiver;->goAsync()Landroid/content/BroadcastReceiver$PendingResult;

    move-result-object v0

    sget-object v1, Lp3/e0;->b:Lv3/d;

    invoke-static {v1}, Ld3/b;->h(Lz2/h;)Lu3/e;

    move-result-object v1

    new-instance v2, Lcom/josski/simpleshortcut/widget/c;

    const/4 v3, 0x0

    invoke-direct {v2, p1, p2, v0, v3}, Lcom/josski/simpleshortcut/widget/c;-><init>(Landroid/content/Context;Ljava/lang/String;Landroid/content/BroadcastReceiver$PendingResult;Lz2/e;)V

    const/4 p1, 0x3

    invoke-static {v1, v3, v3, v2, p1}, Ld3/b;->S0(Lp3/v;Lp3/s;Lp3/w;Lg3/p;I)Lp3/m1;

    :cond_36
    return-void
.end method

.method public onUpdate(Landroid/content/Context;Landroid/appwidget/AppWidgetManager;[I)V
    .registers 8

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "appWidgetManager"

    invoke-static {p2, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "appWidgetIds"

    invoke-static {p3, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    array-length v0, p3

    const/4 v1, 0x0

    :goto_11
    if-ge v1, v0, :cond_1d

    aget v2, p3, v1

    sget-object v3, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;->Companion:Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;

    invoke-virtual {v3, p1, p2, v2}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;->updateWidget(Landroid/content/Context;Landroid/appwidget/AppWidgetManager;I)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_11

    :cond_1d
    return-void
.end method

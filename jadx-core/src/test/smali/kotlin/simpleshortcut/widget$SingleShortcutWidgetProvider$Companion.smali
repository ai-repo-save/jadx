.class public final Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\u000c\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\t\u0008\u0002\u00a2\u0006\u0004\u0008\u0019\u0010\u001aJ\u0015\u0010\u0005\u001a\u00020\u00042\u0006\u0010\u0003\u001a\u00020\u0002\u00a2\u0006\u0004\u0008\u0005\u0010\u0006J%\u0010\u000b\u001a\u00020\n2\u0006\u0010\u0008\u001a\u00020\u00072\u0006\u0010\u0003\u001a\u00020\u00022\u0006\u0010\t\u001a\u00020\u0004\u00a2\u0006\u0004\u0008\u000b\u0010\u000cJ\u001f\u0010\r\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0008\u001a\u00020\u00072\u0006\u0010\u0003\u001a\u00020\u0002\u00a2\u0006\u0004\u0008\r\u0010\u000eJ%\u0010\u0011\u001a\u00020\n2\u0006\u0010\u0008\u001a\u00020\u00072\u0006\u0010\u0010\u001a\u00020\u000f2\u0006\u0010\u0003\u001a\u00020\u0002\u00a2\u0006\u0004\u0008\u0011\u0010\u0012J\u0015\u0010\u0013\u001a\u00020\n2\u0006\u0010\u0008\u001a\u00020\u0007\u00a2\u0006\u0004\u0008\u0013\u0010\u0014R\u0014\u0010\u0015\u001a\u00020\u00048\u0002X\u0082T\u00a2\u0006\u0006\n\u0004\u0008\u0015\u0010\u0016R\u0014\u0010\u0017\u001a\u00020\u00048\u0002X\u0082T\u00a2\u0006\u0006\n\u0004\u0008\u0017\u0010\u0016R\u0014\u0010\u0018\u001a\u00020\u00048\u0002X\u0082T\u00a2\u0006\u0006\n\u0004\u0008\u0018\u0010\u0016\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;",
        "",
        "",
        "widgetId",
        "",
        "prefKey",
        "(I)Ljava/lang/String;",
        "Landroid/content/Context;",
        "context",
        "shortcutId",
        "Lw2/i;",
        "saveShortcutForWidget",
        "(Landroid/content/Context;ILjava/lang/String;)V",
        "getShortcutIdForWidget",
        "(Landroid/content/Context;I)Ljava/lang/String;",
        "Landroid/appwidget/AppWidgetManager;",
        "manager",
        "updateWidget",
        "(Landroid/content/Context;Landroid/appwidget/AppWidgetManager;I)V",
        "notifyAll",
        "(Landroid/content/Context;)V",
        "ACTION_SINGLE_CLICK",
        "Ljava/lang/String;",
        "EXTRA_SHORTCUT_ID",
        "PREFS_NAME",
        "<init>",
        "()V",
        "app_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
.end annotation


# direct methods
.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lh3/f;)V
    .registers 2

    .line 1
    invoke-direct {p0}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final getShortcutIdForWidget(Landroid/content/Context;I)Ljava/lang/String;
    .registers 5

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "single_widget_prefs"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-virtual {p0, p2}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;->prefKey(I)Ljava/lang/String;

    move-result-object p2

    const/4 v0, 0x0

    invoke-interface {p1, p2, v0}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public final notifyAll(Landroid/content/Context;)V
    .registers 7

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {p1}, Landroid/appwidget/AppWidgetManager;->getInstance(Landroid/content/Context;)Landroid/appwidget/AppWidgetManager;

    move-result-object v0

    new-instance v1, Landroid/content/ComponentName;

    const-class v2, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;

    invoke-direct {v1, p1, v2}, Landroid/content/ComponentName;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {v0, v1}, Landroid/appwidget/AppWidgetManager;->getAppWidgetIds(Landroid/content/ComponentName;)[I

    move-result-object v1

    invoke-static {v1}, Ld3/b;->A(Ljava/lang/Object;)V

    array-length v2, v1

    const/4 v3, 0x0

    :goto_19
    if-ge v3, v2, :cond_23

    aget v4, v1, v3

    invoke-virtual {p0, p1, v0, v4}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;->updateWidget(Landroid/content/Context;Landroid/appwidget/AppWidgetManager;I)V

    add-int/lit8 v3, v3, 0x1

    goto :goto_19

    :cond_23
    return-void
.end method

.method public final prefKey(I)Ljava/lang/String;
    .registers 3

    const-string v0, "widget_"

    invoke-static {v0, p1}, La/i;->d(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public final saveShortcutForWidget(Landroid/content/Context;ILjava/lang/String;)V
    .registers 6

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "shortcutId"

    invoke-static {p3, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "single_widget_prefs"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-virtual {p0, p2}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;->prefKey(I)Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1, p2, p3}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public final updateWidget(Landroid/content/Context;Landroid/appwidget/AppWidgetManager;I)V
    .registers 13

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "manager"

    invoke-static {p2, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p0, p1, p3}, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider$Companion;->getShortcutIdForWidget(Landroid/content/Context;I)Ljava/lang/String;

    move-result-object v3

    new-instance v5, Landroid/widget/RemoteViews;

    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    const v1, 0x7f0b0072

    invoke-direct {v5, v0, v1}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    if-nez v3, :cond_30

    const p1, 0x7f08017e

    const-string v0, "\u26a1"

    invoke-virtual {v5, p1, v0}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    const p1, 0x7f08017f

    const-string v0, "Tap to setup"

    invoke-virtual {v5, p1, v0}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    invoke-virtual {p2, p3, v5}, Landroid/appwidget/AppWidgetManager;->updateAppWidget(ILandroid/widget/RemoteViews;)V

    return-void

    :cond_30
    sget-object v0, Lp3/e0;->b:Lv3/d;

    invoke-static {v0}, Ld3/b;->h(Lz2/h;)Lu3/e;

    move-result-object v0

    new-instance v8, Lcom/josski/simpleshortcut/widget/b;

    const/4 v7, 0x0

    move-object v1, v8

    move-object v2, p1

    move v4, p3

    move-object v6, p2

    invoke-direct/range {v1 .. v7}, Lcom/josski/simpleshortcut/widget/b;-><init>(Landroid/content/Context;Ljava/lang/String;ILandroid/widget/RemoteViews;Landroid/appwidget/AppWidgetManager;Lz2/e;)V

    const/4 p1, 0x3

    const/4 p2, 0x0

    invoke-static {v0, p2, p2, v8, p1}, Ld3/b;->S0(Lp3/v;Lp3/s;Lp3/w;Lg3/p;I)Lp3/m1;

    return-void
.end method

.class public final Lcom/josski/simpleshortcut/widget/b;
.super Lb3/h;
.source "SourceFile"

# interfaces
.implements Lg3/p;


# instance fields
.field public d:I

.field public final synthetic e:Landroid/content/Context;

.field public final synthetic f:Ljava/lang/String;

.field public final synthetic g:I

.field public final synthetic h:Landroid/widget/RemoteViews;

.field public final synthetic i:Landroid/appwidget/AppWidgetManager;


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;ILandroid/widget/RemoteViews;Landroid/appwidget/AppWidgetManager;Lz2/e;)V
    .registers 7

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/b;->e:Landroid/content/Context;

    iput-object p2, p0, Lcom/josski/simpleshortcut/widget/b;->f:Ljava/lang/String;

    iput p3, p0, Lcom/josski/simpleshortcut/widget/b;->g:I

    iput-object p4, p0, Lcom/josski/simpleshortcut/widget/b;->h:Landroid/widget/RemoteViews;

    iput-object p5, p0, Lcom/josski/simpleshortcut/widget/b;->i:Landroid/appwidget/AppWidgetManager;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p6}, Lb3/h;-><init>(ILz2/e;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lz2/e;)Lz2/e;
    .registers 10

    new-instance p1, Lcom/josski/simpleshortcut/widget/b;

    iget-object v4, p0, Lcom/josski/simpleshortcut/widget/b;->h:Landroid/widget/RemoteViews;

    iget-object v5, p0, Lcom/josski/simpleshortcut/widget/b;->i:Landroid/appwidget/AppWidgetManager;

    iget-object v1, p0, Lcom/josski/simpleshortcut/widget/b;->e:Landroid/content/Context;

    iget-object v2, p0, Lcom/josski/simpleshortcut/widget/b;->f:Ljava/lang/String;

    iget v3, p0, Lcom/josski/simpleshortcut/widget/b;->g:I

    move-object v0, p1

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lcom/josski/simpleshortcut/widget/b;-><init>(Landroid/content/Context;Ljava/lang/String;ILandroid/widget/RemoteViews;Landroid/appwidget/AppWidgetManager;Lz2/e;)V

    return-object p1
.end method

.method public final f(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    check-cast p1, Lp3/v;

    check-cast p2, Lz2/e;

    invoke-virtual {p0, p1, p2}, Lcom/josski/simpleshortcut/widget/b;->create(Ljava/lang/Object;Lz2/e;)Lz2/e;

    move-result-object p1

    check-cast p1, Lcom/josski/simpleshortcut/widget/b;

    sget-object p2, Lw2/i;->a:Lw2/i;

    invoke-virtual {p1, p2}, Lcom/josski/simpleshortcut/widget/b;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 7

    sget-object v0, La3/a;->c:La3/a;

    iget v1, p0, Lcom/josski/simpleshortcut/widget/b;->d:I

    iget-object v2, p0, Lcom/josski/simpleshortcut/widget/b;->f:Ljava/lang/String;

    const/4 v3, 0x1

    iget-object v4, p0, Lcom/josski/simpleshortcut/widget/b;->e:Landroid/content/Context;

    if-eqz v1, :cond_19

    if-ne v1, v3, :cond_11

    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V

    goto :goto_2f

    :cond_11
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_19
    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V

    sget-object p1, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->Companion:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;

    invoke-virtual {p1, v4}, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;->getDatabase(Landroid/content/Context;)Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    move-result-object p1

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->shortcutDao()Lcom/josski/simpleshortcut/data/ShortcutDao;

    move-result-object p1

    iput v3, p0, Lcom/josski/simpleshortcut/widget/b;->d:I

    invoke-interface {p1, v2, p0}, Lcom/josski/simpleshortcut/data/ShortcutDao;->getById(Ljava/lang/String;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    if-ne p1, v0, :cond_2f

    return-object v0

    :cond_2f
    :goto_2f
    check-cast p1, Lcom/josski/simpleshortcut/data/Shortcut;

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/josski/simpleshortcut/widget/SingleShortcutWidgetProvider;

    invoke-direct {v0, v4, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "com.josski.simpleshortcut.ACTION_SINGLE_CLICK"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "extra_single_shortcut_id"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string v1, "appWidgetId"

    iget v2, p0, Lcom/josski/simpleshortcut/widget/b;->g:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/high16 v1, 0xc000000

    invoke-static {v4, v2, v0, v1}, Landroid/app/PendingIntent;->getBroadcast(Landroid/content/Context;ILandroid/content/Intent;I)Landroid/app/PendingIntent;

    move-result-object v0

    if-eqz p1, :cond_57

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getEmoji()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_59

    :cond_57
    const-string v1, "\u26a1"

    :cond_59
    iget-object v3, p0, Lcom/josski/simpleshortcut/widget/b;->h:Landroid/widget/RemoteViews;

    const v4, 0x7f08017e

    invoke-virtual {v3, v4, v1}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    if-eqz p1, :cond_69

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getLabel()Ljava/lang/String;

    move-result-object p1

    if-nez p1, :cond_6b

    :cond_69
    const-string p1, "\u2014"

    :cond_6b
    const v1, 0x7f08017f

    invoke-virtual {v3, v1, p1}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    invoke-virtual {v3, v4, v0}, Landroid/widget/RemoteViews;->setOnClickPendingIntent(ILandroid/app/PendingIntent;)V

    invoke-virtual {v3, v1, v0}, Landroid/widget/RemoteViews;->setOnClickPendingIntent(ILandroid/app/PendingIntent;)V

    iget-object p1, p0, Lcom/josski/simpleshortcut/widget/b;->i:Landroid/appwidget/AppWidgetManager;

    invoke-virtual {p1, v2, v3}, Landroid/appwidget/AppWidgetManager;->updateAppWidget(ILandroid/widget/RemoteViews;)V

    sget-object p1, Lw2/i;->a:Lw2/i;

    return-object p1
.end method

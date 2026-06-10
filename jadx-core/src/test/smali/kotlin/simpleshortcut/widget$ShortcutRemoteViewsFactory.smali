.class public final Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Landroid/widget/RemoteViewsService$RemoteViewsFactory;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000D\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0008\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\t\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u000f\u0012\u0006\u0010\u0018\u001a\u00020\u0017\u00a2\u0006\u0004\u0008\u001e\u0010\u001fJ\u000f\u0010\u0003\u001a\u00020\u0002H\u0016\u00a2\u0006\u0004\u0008\u0003\u0010\u0004J\u000f\u0010\u0005\u001a\u00020\u0002H\u0016\u00a2\u0006\u0004\u0008\u0005\u0010\u0004J\u000f\u0010\u0006\u001a\u00020\u0002H\u0016\u00a2\u0006\u0004\u0008\u0006\u0010\u0004J\u000f\u0010\u0008\u001a\u00020\u0007H\u0016\u00a2\u0006\u0004\u0008\u0008\u0010\tJ\u0017\u0010\u000c\u001a\u00020\u000b2\u0006\u0010\n\u001a\u00020\u0007H\u0016\u00a2\u0006\u0004\u0008\u000c\u0010\rJ\u0011\u0010\u000e\u001a\u0004\u0018\u00010\u000bH\u0016\u00a2\u0006\u0004\u0008\u000e\u0010\u000fJ\u000f\u0010\u0010\u001a\u00020\u0007H\u0016\u00a2\u0006\u0004\u0008\u0010\u0010\tJ\u0017\u0010\u0012\u001a\u00020\u00112\u0006\u0010\n\u001a\u00020\u0007H\u0016\u00a2\u0006\u0004\u0008\u0012\u0010\u0013J\u000f\u0010\u0015\u001a\u00020\u0014H\u0016\u00a2\u0006\u0004\u0008\u0015\u0010\u0016R\u0014\u0010\u0018\u001a\u00020\u00178\u0002X\u0082\u0004\u00a2\u0006\u0006\n\u0004\u0008\u0018\u0010\u0019R\u001c\u0010\u001c\u001a\u0008\u0012\u0004\u0012\u00020\u001b0\u001a8\u0002@\u0002X\u0082\u000e\u00a2\u0006\u0006\n\u0004\u0008\u001c\u0010\u001d\u00a8\u0006 "
    }
    d2 = {
        "Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;",
        "Landroid/widget/RemoteViewsService$RemoteViewsFactory;",
        "Lw2/i;",
        "onCreate",
        "()V",
        "onDataSetChanged",
        "onDestroy",
        "",
        "getCount",
        "()I",
        "position",
        "Landroid/widget/RemoteViews;",
        "getViewAt",
        "(I)Landroid/widget/RemoteViews;",
        "getLoadingView",
        "()Landroid/widget/RemoteViews;",
        "getViewTypeCount",
        "",
        "getItemId",
        "(I)J",
        "",
        "hasStableIds",
        "()Z",
        "Landroid/content/Context;",
        "context",
        "Landroid/content/Context;",
        "",
        "Lcom/josski/simpleshortcut/data/Shortcut;",
        "shortcuts",
        "Ljava/util/List;",
        "<init>",
        "(Landroid/content/Context;)V",
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
.field private final context:Landroid/content/Context;

.field private shortcuts:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->context:Landroid/content/Context;

    sget-object p1, Lx2/n;->c:Lx2/n;

    iput-object p1, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->shortcuts:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public getCount()I
    .registers 2

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->shortcuts:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getItemId(I)J
    .registers 4

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->shortcuts:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/josski/simpleshortcut/data/Shortcut;

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getId()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result p1

    int-to-long v0, p1

    return-wide v0
.end method

.method public getLoadingView()Landroid/widget/RemoteViews;
    .registers 2

    const/4 v0, 0x0

    return-object v0
.end method

.method public getViewAt(I)Landroid/widget/RemoteViews;
    .registers 5

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->shortcuts:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    const v1, 0x7f0b0070

    if-lt p1, v0, :cond_17

    new-instance p1, Landroid/widget/RemoteViews;

    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->context:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p1, v0, v1}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    return-object p1

    :cond_17
    iget-object v0, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->shortcuts:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/josski/simpleshortcut/data/Shortcut;

    new-instance v0, Landroid/widget/RemoteViews;

    iget-object v2, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v0, v2, v1}, Landroid/widget/RemoteViews;-><init>(Ljava/lang/String;I)V

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getEmoji()Ljava/lang/String;

    move-result-object v1

    const v2, 0x7f0800d6

    invoke-virtual {v0, v2, v1}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    const v1, 0x7f0800d7

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getLabel()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/widget/RemoteViews;->setTextViewText(ILjava/lang/CharSequence;)V

    new-instance v1, Landroid/content/Intent;

    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    const-string v2, "extra_shortcut_id"

    invoke-virtual {p1}, Lcom/josski/simpleshortcut/data/Shortcut;->getId()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, v2, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const p1, 0x7f0800d8

    invoke-virtual {v0, p1, v1}, Landroid/widget/RemoteViews;->setOnClickFillInIntent(ILandroid/content/Intent;)V

    return-object v0
.end method

.method public getViewTypeCount()I
    .registers 2

    const/4 v0, 0x1

    return v0
.end method

.method public hasStableIds()Z
    .registers 2

    const/4 v0, 0x1

    return v0
.end method

.method public onCreate()V
    .registers 1

    return-void
.end method

.method public onDataSetChanged()V
    .registers 3

    sget-object v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->Companion:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;

    iget-object v1, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->context:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;->getDatabase(Landroid/content/Context;)Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    move-result-object v0

    invoke-virtual {v0}, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->shortcutDao()Lcom/josski/simpleshortcut/data/ShortcutDao;

    move-result-object v0

    invoke-interface {v0}, Lcom/josski/simpleshortcut/data/ShortcutDao;->getAllShortcutsSync()Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/josski/simpleshortcut/widget/ShortcutRemoteViewsFactory;->shortcuts:Ljava/util/List;

    return-void
.end method

.method public onDestroy()V
    .registers 1

    return-void
.end method

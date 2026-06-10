.class public final Lcom/josski/simpleshortcut/widget/ShortcutPublisher;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\t\u0008\u0002\u00a2\u0006\u0004\u0008\n\u0010\u000bJ#\u0010\u0008\u001a\u00020\u00072\u0006\u0010\u0003\u001a\u00020\u00022\u000c\u0010\u0006\u001a\u0008\u0012\u0004\u0012\u00020\u00050\u0004\u00a2\u0006\u0004\u0008\u0008\u0010\t\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/widget/ShortcutPublisher;",
        "",
        "Landroid/content/Context;",
        "context",
        "",
        "Lcom/josski/simpleshortcut/data/Shortcut;",
        "shortcuts",
        "Lw2/i;",
        "publishDynamicShortcuts",
        "(Landroid/content/Context;Ljava/util/List;)V",
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


# static fields
.field public static final INSTANCE:Lcom/josski/simpleshortcut/widget/ShortcutPublisher;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    new-instance v0, Lcom/josski/simpleshortcut/widget/ShortcutPublisher;

    invoke-direct {v0}, Lcom/josski/simpleshortcut/widget/ShortcutPublisher;-><init>()V

    sput-object v0, Lcom/josski/simpleshortcut/widget/ShortcutPublisher;->INSTANCE:Lcom/josski/simpleshortcut/widget/ShortcutPublisher;

    return-void
.end method

.method private constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final publishDynamicShortcuts(Landroid/content/Context;Ljava/util/List;)V
    .registers 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;)V"
        }
    .end annotation

    const-string v0, "context"

    invoke-static {p1, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "shortcuts"

    invoke-static {p2, v0}, Ld3/b;->E(Ljava/lang/Object;Ljava/lang/String;)V

    const-class v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/pm/ShortcutManager;

    invoke-virtual {v0}, Landroid/content/pm/ShortcutManager;->getMaxShortcutCountPerActivity()I

    move-result v1

    if-ltz v1, :cond_ee

    sget-object v2, Lx2/n;->c:Lx2/n;

    const/4 v3, 0x0

    if-nez v1, :cond_1e

    goto :goto_6f

    :cond_1e
    invoke-interface {p2}, Ljava/util/Collection;->size()I

    move-result v4

    if-lt v1, v4, :cond_29

    invoke-static {p2}, Lx2/l;->w2(Ljava/lang/Iterable;)Ljava/util/List;

    move-result-object v2

    goto :goto_6f

    :cond_29
    const/4 v4, 0x1

    if-ne v1, v4, :cond_43

    invoke-interface {p2}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_3b

    invoke-interface {p2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p2

    invoke-static {p2}, Ld3/b;->U0(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    goto :goto_6f

    :cond_3b
    new-instance p1, Ljava/util/NoSuchElementException;

    const-string p2, "List is empty."

    invoke-direct {p1, p2}, Ljava/util/NoSuchElementException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_43
    new-instance v5, Ljava/util/ArrayList;

    invoke-direct {v5, v1}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {p2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object p2

    move v6, v3

    :cond_4d
    invoke-interface {p2}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_5d

    invoke-interface {p2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/2addr v6, v4

    if-ne v6, v1, :cond_4d

    :cond_5d
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result p2

    if-eqz p2, :cond_6f

    if-eq p2, v4, :cond_67

    move-object v2, v5

    goto :goto_6f

    :cond_67
    invoke-virtual {v5, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object p2

    invoke-static {p2}, Ld3/b;->U0(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    :cond_6f
    :goto_6f
    new-instance p2, Ljava/util/ArrayList;

    invoke-interface {v2}, Ljava/util/Collection;->size()I

    move-result v1

    invoke-direct {p2, v1}, Ljava/util/ArrayList;-><init>(I)V

    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_7c
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_ea

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    add-int/lit8 v4, v3, 0x1

    if-ltz v3, :cond_e5

    check-cast v2, Lcom/josski/simpleshortcut/data/Shortcut;

    new-instance v5, Landroid/content/Intent;

    const-class v6, Lcom/josski/simpleshortcut/MainActivity;

    invoke-direct {v5, p1, v6}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v6, "android.intent.action.VIEW"

    invoke-virtual {v5, v6}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    invoke-virtual {v2}, Lcom/josski/simpleshortcut/data/Shortcut;->getId()Ljava/lang/String;

    move-result-object v6

    const-string v7, "extra_shortcut_id"

    invoke-virtual {v5, v7, v6}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    new-instance v6, Landroid/content/pm/ShortcutInfo$Builder;

    new-instance v7, Ljava/lang/StringBuilder;

    const-string v8, "shortcut_"

    invoke-direct {v7, v8}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Lcom/josski/simpleshortcut/data/Shortcut;->getId()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, p1, v7}, Landroid/content/pm/ShortcutInfo$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    invoke-virtual {v2}, Lcom/josski/simpleshortcut/data/Shortcut;->getLabel()Ljava/lang/String;

    move-result-object v7

    const/16 v8, 0xa

    invoke-static {v7, v8}, Lo3/h;->w2(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Landroid/content/pm/ShortcutInfo$Builder;->setShortLabel(Ljava/lang/CharSequence;)Landroid/content/pm/ShortcutInfo$Builder;

    move-result-object v6

    invoke-virtual {v2}, Lcom/josski/simpleshortcut/data/Shortcut;->getLabel()Ljava/lang/String;

    move-result-object v2

    const/16 v7, 0x19

    invoke-static {v2, v7}, Lo3/h;->w2(Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v6, v2}, Landroid/content/pm/ShortcutInfo$Builder;->setLongLabel(Ljava/lang/CharSequence;)Landroid/content/pm/ShortcutInfo$Builder;

    move-result-object v2

    invoke-virtual {v2, v5}, Landroid/content/pm/ShortcutInfo$Builder;->setIntent(Landroid/content/Intent;)Landroid/content/pm/ShortcutInfo$Builder;

    move-result-object v2

    invoke-virtual {v2, v3}, Landroid/content/pm/ShortcutInfo$Builder;->setRank(I)Landroid/content/pm/ShortcutInfo$Builder;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/pm/ShortcutInfo$Builder;->build()Landroid/content/pm/ShortcutInfo;

    move-result-object v2

    invoke-virtual {p2, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    move v3, v4

    goto :goto_7c

    :cond_e5
    invoke-static {}, Ld3/b;->X1()V

    const/4 p1, 0x0

    throw p1

    :cond_ea
    invoke-virtual {v0, p2}, Landroid/content/pm/ShortcutManager;->setDynamicShortcuts(Ljava/util/List;)Z

    return-void

    :cond_ee
    new-instance p1, Ljava/lang/StringBuilder;

    const-string p2, "Requested element count "

    invoke-direct {p1, p2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p2, " is less than zero."

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance p2, Ljava/lang/IllegalArgumentException;

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-direct {p2, p1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p2
.end method

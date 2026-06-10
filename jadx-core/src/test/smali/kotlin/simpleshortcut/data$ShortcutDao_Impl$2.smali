.class Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$2;
.super Landroidx/room/l;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;-><init>(Landroidx/room/e0;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/room/l;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/e0;)V
    .registers 3

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$2;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-direct {p0, p2}, Landroidx/room/l;-><init>(Landroidx/room/e0;)V

    return-void
.end method


# virtual methods
.method public bind(Lj1/h;Lcom/josski/simpleshortcut/data/Shortcut;)V
    .registers 4

    .line 1
    const/4 v0, 0x1

    .line 2
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getId()Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1, p2, v0}, Lj1/f;->h(Ljava/lang/String;I)V

    return-void
.end method

.method public bridge synthetic bind(Lj1/h;Ljava/lang/Object;)V
    .registers 3

    .line 3
    check-cast p2, Lcom/josski/simpleshortcut/data/Shortcut;

    invoke-virtual {p0, p1, p2}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$2;->bind(Lj1/h;Lcom/josski/simpleshortcut/data/Shortcut;)V

    return-void
.end method

.method public createQuery()Ljava/lang/String;
    .registers 2

    const-string v0, "DELETE FROM `shortcuts` WHERE `id` = ?"

    return-object v0
.end method

.class Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$3;
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

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$3;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-direct {p0, p2}, Landroidx/room/l;-><init>(Landroidx/room/e0;)V

    return-void
.end method


# virtual methods
.method public bind(Lj1/h;Lcom/josski/simpleshortcut/data/Shortcut;)V
    .registers 7

    .line 2
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getId()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x1

    invoke-interface {p1, v0, v1}, Lj1/f;->h(Ljava/lang/String;I)V

    const/4 v0, 0x2

    .line 3
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getLabel()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1, v0}, Lj1/f;->h(Ljava/lang/String;I)V

    const/4 v0, 0x3

    .line 4
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1, v0}, Lj1/f;->h(Ljava/lang/String;I)V

    const/4 v0, 0x4

    .line 5
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getDeeplink()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1, v0}, Lj1/f;->h(Ljava/lang/String;I)V

    const/4 v0, 0x5

    .line 6
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getEmoji()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1, v0}, Lj1/f;->h(Ljava/lang/String;I)V

    .line 7
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getRank()I

    move-result v0

    int-to-long v0, v0

    const/4 v2, 0x6

    invoke-interface {p1, v2, v0, v1}, Lj1/f;->p(IJ)V

    const/4 v0, 0x7

    .line 8
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getCreatedAt()J

    move-result-wide v1

    invoke-interface {p1, v0, v1, v2}, Lj1/f;->p(IJ)V

    const/16 v0, 0x8

    .line 9
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getCategory()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p1, v1, v0}, Lj1/f;->h(Ljava/lang/String;I)V

    .line 10
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->isPinned()Z

    move-result v0

    const/16 v1, 0x9

    int-to-long v2, v0

    .line 11
    invoke-interface {p1, v1, v2, v3}, Lj1/f;->p(IJ)V

    .line 12
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getTapCount()I

    move-result v0

    int-to-long v0, v0

    const/16 v2, 0xa

    invoke-interface {p1, v2, v0, v1}, Lj1/f;->p(IJ)V

    const/16 v0, 0xb

    .line 13
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getLastUsedAt()J

    move-result-wide v1

    invoke-interface {p1, v0, v1, v2}, Lj1/f;->p(IJ)V

    const/16 v0, 0xc

    .line 14
    invoke-virtual {p2}, Lcom/josski/simpleshortcut/data/Shortcut;->getId()Ljava/lang/String;

    move-result-object p2

    invoke-interface {p1, p2, v0}, Lj1/f;->h(Ljava/lang/String;I)V

    return-void
.end method

.method public bridge synthetic bind(Lj1/h;Ljava/lang/Object;)V
    .registers 3

    .line 1
    check-cast p2, Lcom/josski/simpleshortcut/data/Shortcut;

    invoke-virtual {p0, p1, p2}, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$3;->bind(Lj1/h;Lcom/josski/simpleshortcut/data/Shortcut;)V

    return-void
.end method

.method public createQuery()Ljava/lang/String;
    .registers 2

    const-string v0, "UPDATE OR ABORT `shortcuts` SET `id` = ?,`label` = ?,`packageName` = ?,`deeplink` = ?,`emoji` = ?,`rank` = ?,`createdAt` = ?,`category` = ?,`isPinned` = ?,`tapCount` = ?,`lastUsedAt` = ? WHERE `id` = ?"

    return-object v0
.end method

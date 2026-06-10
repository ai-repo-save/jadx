.class Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$4;
.super Landroidx/room/k0;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;-><init>(Landroidx/room/e0;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;Landroidx/room/e0;)V
    .registers 3

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutDao_Impl$4;->this$0:Lcom/josski/simpleshortcut/data/ShortcutDao_Impl;

    invoke-direct {p0, p2}, Landroidx/room/k0;-><init>(Landroidx/room/e0;)V

    return-void
.end method


# virtual methods
.method public createQuery()Ljava/lang/String;
    .registers 2

    const-string v0, "UPDATE shortcuts SET tapCount = tapCount + 1, lastUsedAt = ? WHERE id = ?"

    return-object v0
.end method

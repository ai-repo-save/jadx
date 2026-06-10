.class final Lcom/josski/simpleshortcut/data/ShortcutRepository$updateAll$1;
.super Lb3/c;
.source "SourceFile"


# annotations
.annotation runtime Lb3/e;
    c = "com.josski.simpleshortcut.data.ShortcutRepository"
    f = "ShortcutRepository.kt"
    l = {
        0x21,
        0x22
    }
    m = "updateAll"
.end annotation

.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/josski/simpleshortcut/data/ShortcutRepository;->updateAll(Ljava/util/List;Lz2/e;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    k = 0x3
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field L$0:Ljava/lang/Object;

.field label:I

.field synthetic result:Ljava/lang/Object;

.field final synthetic this$0:Lcom/josski/simpleshortcut/data/ShortcutRepository;


# direct methods
.method public constructor <init>(Lcom/josski/simpleshortcut/data/ShortcutRepository;Lz2/e;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/josski/simpleshortcut/data/ShortcutRepository;",
            "Lz2/e;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutRepository$updateAll$1;->this$0:Lcom/josski/simpleshortcut/data/ShortcutRepository;

    invoke-direct {p0, p2}, Lb3/c;-><init>(Lz2/e;)V

    return-void
.end method


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    iput-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutRepository$updateAll$1;->result:Ljava/lang/Object;

    iget p1, p0, Lcom/josski/simpleshortcut/data/ShortcutRepository$updateAll$1;->label:I

    const/high16 v0, -0x80000000

    or-int/2addr p1, v0

    iput p1, p0, Lcom/josski/simpleshortcut/data/ShortcutRepository$updateAll$1;->label:I

    iget-object p1, p0, Lcom/josski/simpleshortcut/data/ShortcutRepository$updateAll$1;->this$0:Lcom/josski/simpleshortcut/data/ShortcutRepository;

    const/4 v0, 0x0

    invoke-virtual {p1, v0, p0}, Lcom/josski/simpleshortcut/data/ShortcutRepository;->updateAll(Ljava/util/List;Lz2/e;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

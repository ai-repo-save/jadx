.class public interface abstract Lcom/josski/simpleshortcut/data/ShortcutDao;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/josski/simpleshortcut/data/ShortcutDao$DefaultImpls;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0018\u0002\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u000e\n\u0002\u0008\n\n\u0002\u0018\u0002\n\u0002\u0008\u0007\n\u0002\u0010\t\n\u0002\u0008\u0004\u0008g\u0018\u00002\u00020\u0001J\u001b\u0010\u0005\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00040\u00030\u0002H\'\u00a2\u0006\u0004\u0008\u0005\u0010\u0006J\u0015\u0010\u0007\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\'\u00a2\u0006\u0004\u0008\u0007\u0010\u0008J\u001a\u0010\u000b\u001a\u0004\u0018\u00010\u00042\u0006\u0010\n\u001a\u00020\tH\u00a7@\u00a2\u0006\u0004\u0008\u000b\u0010\u000cJ\u001b\u0010\r\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\t0\u00030\u0002H\'\u00a2\u0006\u0004\u0008\r\u0010\u0006J#\u0010\u000f\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00040\u00030\u00022\u0006\u0010\u000e\u001a\u00020\tH\'\u00a2\u0006\u0004\u0008\u000f\u0010\u0010J#\u0010\u0012\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00040\u00030\u00022\u0006\u0010\u0011\u001a\u00020\tH\'\u00a2\u0006\u0004\u0008\u0012\u0010\u0010J\u0018\u0010\u0015\u001a\u00020\u00142\u0006\u0010\u0013\u001a\u00020\u0004H\u00a7@\u00a2\u0006\u0004\u0008\u0015\u0010\u0016J\u0018\u0010\u0017\u001a\u00020\u00142\u0006\u0010\u0013\u001a\u00020\u0004H\u00a7@\u00a2\u0006\u0004\u0008\u0017\u0010\u0016J\u0018\u0010\u0018\u001a\u00020\u00142\u0006\u0010\u0013\u001a\u00020\u0004H\u00a7@\u00a2\u0006\u0004\u0008\u0018\u0010\u0016J\u001e\u0010\u001a\u001a\u00020\u00142\u000c\u0010\u0019\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u0003H\u00a7@\u00a2\u0006\u0004\u0008\u001a\u0010\u001bJ\"\u0010\u001e\u001a\u00020\u00142\u0006\u0010\n\u001a\u00020\t2\u0008\u0008\u0002\u0010\u001d\u001a\u00020\u001cH\u00a7@\u00a2\u0006\u0004\u0008\u001e\u0010\u001f\u00a8\u0006 "
    }
    d2 = {
        "Lcom/josski/simpleshortcut/data/ShortcutDao;",
        "",
        "Ls3/e;",
        "",
        "Lcom/josski/simpleshortcut/data/Shortcut;",
        "getAllShortcuts",
        "()Ls3/e;",
        "getAllShortcutsSync",
        "()Ljava/util/List;",
        "",
        "id",
        "getById",
        "(Ljava/lang/String;Lz2/e;)Ljava/lang/Object;",
        "getAllCategories",
        "category",
        "getByCategory",
        "(Ljava/lang/String;)Ls3/e;",
        "query",
        "search",
        "shortcut",
        "Lw2/i;",
        "insert",
        "(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;",
        "delete",
        "update",
        "shortcuts",
        "updateAll",
        "(Ljava/util/List;Lz2/e;)Ljava/lang/Object;",
        "",
        "now",
        "incrementTapCount",
        "(Ljava/lang/String;JLz2/e;)Ljava/lang/Object;",
        "app_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
.end annotation


# virtual methods
.method public abstract delete(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation
.end method

.method public abstract getAllCategories()Ls3/e;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ls3/e;"
        }
    .end annotation
.end method

.method public abstract getAllShortcuts()Ls3/e;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ls3/e;"
        }
    .end annotation
.end method

.method public abstract getAllShortcutsSync()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getByCategory(Ljava/lang/String;)Ls3/e;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ls3/e;"
        }
    .end annotation
.end method

.method public abstract getById(Ljava/lang/String;Lz2/e;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation
.end method

.method public abstract incrementTapCount(Ljava/lang/String;JLz2/e;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "J",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation
.end method

.method public abstract insert(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation
.end method

.method public abstract search(Ljava/lang/String;)Ls3/e;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ls3/e;"
        }
    .end annotation
.end method

.method public abstract update(Lcom/josski/simpleshortcut/data/Shortcut;Lz2/e;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation
.end method

.method public abstract updateAll(Ljava/util/List;Lz2/e;)Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/josski/simpleshortcut/data/Shortcut;",
            ">;",
            "Lz2/e;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation
.end method

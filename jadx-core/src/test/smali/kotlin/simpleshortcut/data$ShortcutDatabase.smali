.class public abstract Lcom/josski/simpleshortcut/data/ShortcutDatabase;
.super Landroidx/room/e0;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0010\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\u0008\'\u0018\u0000 \u00072\u00020\u0001:\u0001\u0007B\u0007\u00a2\u0006\u0004\u0008\u0005\u0010\u0006J\u000f\u0010\u0003\u001a\u00020\u0002H&\u00a2\u0006\u0004\u0008\u0003\u0010\u0004\u00a8\u0006\u0008"
    }
    d2 = {
        "Lcom/josski/simpleshortcut/data/ShortcutDatabase;",
        "Landroidx/room/e0;",
        "Lcom/josski/simpleshortcut/data/ShortcutDao;",
        "shortcutDao",
        "()Lcom/josski/simpleshortcut/data/ShortcutDao;",
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
.field public static final Companion:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;

.field private static volatile INSTANCE:Lcom/josski/simpleshortcut/data/ShortcutDatabase;

.field private static final MIGRATION_1_2:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1;

.field private static final MIGRATION_2_3:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;


# direct methods
.method static constructor <clinit>()V
    .registers 2

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;-><init>(Lh3/f;)V

    sput-object v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->Companion:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion;

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1;

    invoke-direct {v0}, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1;-><init>()V

    sput-object v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->MIGRATION_1_2:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1;

    new-instance v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;

    invoke-direct {v0}, Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;-><init>()V

    sput-object v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->MIGRATION_2_3:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroidx/room/e0;-><init>()V

    return-void
.end method

.method public static final synthetic access$getINSTANCE$cp()Lcom/josski/simpleshortcut/data/ShortcutDatabase;
    .registers 1

    sget-object v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->INSTANCE:Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    return-object v0
.end method

.method public static final synthetic access$getMIGRATION_1_2$cp()Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1;
    .registers 1

    sget-object v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->MIGRATION_1_2:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_1_2$1;

    return-object v0
.end method

.method public static final synthetic access$getMIGRATION_2_3$cp()Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;
    .registers 1

    sget-object v0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->MIGRATION_2_3:Lcom/josski/simpleshortcut/data/ShortcutDatabase$Companion$MIGRATION_2_3$1;

    return-object v0
.end method

.method public static final synthetic access$setINSTANCE$cp(Lcom/josski/simpleshortcut/data/ShortcutDatabase;)V
    .registers 1

    sput-object p0, Lcom/josski/simpleshortcut/data/ShortcutDatabase;->INSTANCE:Lcom/josski/simpleshortcut/data/ShortcutDatabase;

    return-void
.end method


# virtual methods
.method public abstract shortcutDao()Lcom/josski/simpleshortcut/data/ShortcutDao;
.end method

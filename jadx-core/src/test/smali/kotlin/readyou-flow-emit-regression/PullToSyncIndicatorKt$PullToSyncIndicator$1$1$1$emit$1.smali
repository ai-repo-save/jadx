.class final Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;
.super Lkotlin/coroutines/jvm/internal/ContinuationImpl;
.source "PullToSyncIndicator.kt"

# Exported from Read You 0.16.1 (FlowCollector.emit ContinuationImpl).

# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;->emit(ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "me.ash.reader.ui.page.home.flow.PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1"
    f = "PullToSyncIndicator.kt"
    l = {
        0x56,
        0x57,
        0x5c,
        0x5d
    }
    m = "emit"
.end annotation


# instance fields
.field Z$0:Z

.field label:I

.field synthetic result:Ljava/lang/Object;

.field final synthetic this$0:Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1<",
            "TT;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;Lkotlin/coroutines/Continuation;)V
    .registers 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1<",
            "-TT;>;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;->this$0:Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;

    invoke-direct {p0, p2}, Lkotlin/coroutines/jvm/internal/ContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    iput-object p1, p0, Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;->result:Ljava/lang/Object;

    iget p1, p0, Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;->label:I

    const/high16 v0, -0x80000000

    or-int/2addr p1, v0

    iput p1, p0, Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;->label:I

    iget-object p1, p0, Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;->this$0:Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;

    const/4 v0, 0x0

    invoke-virtual {p1, v0, p0}, Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;->emit(ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

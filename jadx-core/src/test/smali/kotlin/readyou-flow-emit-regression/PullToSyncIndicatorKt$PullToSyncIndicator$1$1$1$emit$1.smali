.class final Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;
.super Lkotlin/coroutines/jvm/internal/ContinuationImpl;
.source "PullToSyncIndicator.kt"

# Exported from Read You 0.16.1 (FlowCollector.emit ContinuationImpl).
# Minimal bytecode reproducer for ModVisitor narrowing `this` from Continuation.

.field Z$0:Z

.field label:I

.field synthetic result:Ljava/lang/Object;

.field final synthetic this$0:Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;

.method public constructor <init>(Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;Lkotlin/coroutines/Continuation;)V
    .registers 3

    iput-object p1, p0, Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1$emit$1;->this$0:Lme/ash/reader/ui/page/home/flow/PullToSyncIndicatorKt$PullToSyncIndicator$1$1$1;

    invoke-direct {p0, p2}, Lkotlin/coroutines/jvm/internal/ContinuationImpl;-><init>(Lkotlin/coroutines/Continuation;)V

    return-void
.end method

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

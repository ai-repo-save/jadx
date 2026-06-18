.class public abstract Lkotlin/coroutines/jvm/internal/BaseContinuationImpl;
.super Ljava/lang/Object;
.implements Lkotlin/coroutines/Continuation;

.field protected label:I

.field synthetic result:Ljava/lang/Object;

.method public constructor <init>(Lkotlin/coroutines/Continuation;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public getContext()Lkotlin/coroutines/CoroutineContext;
    .registers 2

    const/4 v0, 0x0

    return-object v0
.end method

.method public resumeWith(Ljava/lang/Object;)V
    .registers 2

    return-void
.end method

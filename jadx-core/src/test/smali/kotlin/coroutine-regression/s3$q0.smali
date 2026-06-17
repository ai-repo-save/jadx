.class public final Ls3/q0;
.super Lt3/b;
.source "SourceFile"

# interfaces
.implements Ls3/x;
.implements Ls3/e;
.implements Lt3/w;


# static fields
.field public static final synthetic h:Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;


# instance fields
.field private volatile synthetic _state$volatile:Ljava/lang/Object;

.field public g:I


# direct methods
.method static constructor <clinit>()V
    .registers 3

    const-class v0, Ljava/lang/Object;

    const-string v1, "_state$volatile"

    const-class v2, Ls3/q0;

    invoke-static {v2, v0, v1}, Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;->newUpdater(Ljava/lang/Class;Ljava/lang/Class;Ljava/lang/String;)Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;

    move-result-object v0

    sput-object v0, Ls3/q0;->h:Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;

    return-void
.end method

.method public constructor <init>(Ljava/lang/Object;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Ls3/q0;->_state$volatile:Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final a()V
    .registers 3

    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "MutableStateFlow.resetReplayCache is not supported"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final b(Ljava/lang/Object;Lz2/e;)Ljava/lang/Object;
    .registers 3

    invoke-virtual {p0, p1}, Ls3/q0;->k(Ljava/lang/Object;)V

    sget-object p1, Lw2/i;->a:Lw2/i;

    return-object p1
.end method

.method public final c(Ls3/f;Lz2/e;)Ljava/lang/Object;
    .registers 19

    move-object/from16 v0, p2

    instance-of v1, v0, Ls3/p0;

    if-eqz v1, :cond_17

    move-object v1, v0

    check-cast v1, Ls3/p0;

    iget v2, v1, Ls3/p0;->j:I

    const/high16 v3, -0x80000000

    and-int v4, v2, v3

    if-eqz v4, :cond_17

    sub-int/2addr v2, v3

    iput v2, v1, Ls3/p0;->j:I

    move-object/from16 v2, p0

    goto :goto_1e

    :cond_17
    new-instance v1, Ls3/p0;

    move-object/from16 v2, p0

    invoke-direct {v1, v2, v0}, Ls3/p0;-><init>(Ls3/q0;Lz2/e;)V

    :goto_1e
    iget-object v0, v1, Ls3/p0;->h:Ljava/lang/Object;

    sget-object v3, La3/a;->c:La3/a;

    iget v4, v1, Ls3/p0;->j:I

    const/4 v6, 0x3

    const/4 v7, 0x2

    const/4 v8, 0x1

    if-eqz v4, :cond_61

    if-eq v4, v8, :cond_57

    if-eq v4, v7, :cond_49

    if-ne v4, v6, :cond_41

    iget-object v4, v1, Ls3/p0;->g:Ljava/lang/Object;

    iget-object v9, v1, Ls3/p0;->f:Lp3/w0;

    iget-object v10, v1, Ls3/p0;->e:Ls3/r0;

    iget-object v11, v1, Ls3/p0;->d:Ls3/f;

    iget-object v12, v1, Ls3/p0;->c:Ls3/q0;

    :try_start_39
    invoke-static {v0}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_3c
    .catchall {:try_start_39 .. :try_end_3c} :catchall_3e

    move-object v0, v4

    goto :goto_7d

    :catchall_3e
    move-exception v0

    goto/16 :goto_fc

    :cond_41
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :cond_49
    iget-object v4, v1, Ls3/p0;->g:Ljava/lang/Object;

    iget-object v9, v1, Ls3/p0;->f:Lp3/w0;

    iget-object v10, v1, Ls3/p0;->e:Ls3/r0;

    iget-object v11, v1, Ls3/p0;->d:Ls3/f;

    iget-object v12, v1, Ls3/p0;->c:Ls3/q0;

    :try_start_53
    invoke-static {v0}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_56
    .catchall {:try_start_53 .. :try_end_56} :catchall_3e

    goto :goto_b5

    :cond_57
    iget-object v10, v1, Ls3/p0;->e:Ls3/r0;

    iget-object v4, v1, Ls3/p0;->d:Ls3/f;

    iget-object v12, v1, Ls3/p0;->c:Ls3/q0;

    :try_start_5d
    invoke-static {v0}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_60
    .catchall {:try_start_5d .. :try_end_60} :catchall_3e

    goto :goto_6e

    :cond_61
    invoke-static {v0}, Ld3/b;->Y1(Ljava/lang/Object;)V

    invoke-virtual/range {p0 .. p0}, Lt3/b;->f()Lt3/d;

    move-result-object v0

    check-cast v0, Ls3/r0;

    move-object/from16 v4, p1

    move-object v10, v0

    move-object v12, v2

    :goto_6e
    :try_start_6e
    invoke-interface {v1}, Lz2/e;->getContext()Lz2/j;

    move-result-object v0

    sget-object v9, Lp3/t;->d:Lp3/t;

    invoke-interface {v0, v9}, Lz2/j;->g(Lz2/i;)Lz2/h;

    move-result-object v0

    check-cast v0, Lp3/w0;

    move-object v9, v0

    move-object v11, v4

    const/4 v0, 0x0

    :cond_7d
    :goto_7d
    sget-object v4, Ls3/q0;->h:Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;

    invoke-virtual {v4, v12}, Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    if-eqz v9, :cond_93

    invoke-interface {v9}, Lp3/w0;->b()Z

    move-result v13

    if-eqz v13, :cond_8c

    goto :goto_93

    :cond_8c
    check-cast v9, Lp3/f1;

    invoke-virtual {v9}, Lp3/f1;->A()Ljava/util/concurrent/CancellationException;

    move-result-object v0

    throw v0

    :cond_93
    :goto_93
    if-eqz v0, :cond_9b

    invoke-static {v0, v4}, Ld3/b;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v13

    if-nez v13, :cond_b6

    :cond_9b
    sget-object v0, Lt3/c;->b:Lu0/t;

    if-ne v4, v0, :cond_a1

    const/4 v0, 0x0

    goto :goto_a2

    :cond_a1
    move-object v0, v4

    :goto_a2
    iput-object v12, v1, Ls3/p0;->c:Ls3/q0;

    iput-object v11, v1, Ls3/p0;->d:Ls3/f;

    iput-object v10, v1, Ls3/p0;->e:Ls3/r0;

    iput-object v9, v1, Ls3/p0;->f:Lp3/w0;

    iput-object v4, v1, Ls3/p0;->g:Ljava/lang/Object;

    iput v7, v1, Ls3/p0;->j:I

    invoke-interface {v11, v0, v1}, Ls3/f;->b(Ljava/lang/Object;Lz2/e;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v3, :cond_b5

    return-object v3

    :cond_b5
    :goto_b5
    move-object v0, v4

    :cond_b6
    iget-object v4, v10, Ls3/r0;->a:Ljava/util/concurrent/atomic/AtomicReference;

    sget-object v13, Ls3/b0;->b:Lu0/t;

    invoke-virtual {v4, v13}, Ljava/util/concurrent/atomic/AtomicReference;->getAndSet(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Ld3/b;->A(Ljava/lang/Object;)V

    sget-object v14, Ls3/b0;->c:Lu0/t;

    if-ne v4, v14, :cond_c6

    goto :goto_7d

    :cond_c6
    iput-object v12, v1, Ls3/p0;->c:Ls3/q0;

    iput-object v11, v1, Ls3/p0;->d:Ls3/f;

    iput-object v10, v1, Ls3/p0;->e:Ls3/r0;

    iput-object v9, v1, Ls3/p0;->f:Lp3/w0;

    iput-object v0, v1, Ls3/p0;->g:Ljava/lang/Object;

    iput v6, v1, Ls3/p0;->j:I

    new-instance v4, Lp3/g;

    invoke-static {v1}, Ld3/b;->E0(Lz2/e;)Lz2/e;

    move-result-object v14

    invoke-direct {v4, v8, v14}, Lp3/g;-><init>(ILz2/e;)V

    invoke-virtual {v4}, Lp3/g;->r()V

    iget-object v14, v10, Ls3/r0;->a:Ljava/util/concurrent/atomic/AtomicReference;

    :cond_e0
    invoke-virtual {v14, v13, v4}, Ljava/util/concurrent/atomic/AtomicReference;->compareAndSet(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v15

    sget-object v5, Lw2/i;->a:Lw2/i;

    if-eqz v15, :cond_e9

    goto :goto_f2

    :cond_e9
    invoke-virtual {v14}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v15

    if-eq v15, v13, :cond_e0

    invoke-virtual {v4, v5}, Lp3/g;->resumeWith(Ljava/lang/Object;)V

    :goto_f2
    invoke-virtual {v4}, Lp3/g;->q()Ljava/lang/Object;

    move-result-object v4
    :try_end_f6
    .catchall {:try_start_6e .. :try_end_f6} :catchall_3e

    if-ne v4, v3, :cond_f9

    move-object v5, v4

    :cond_f9
    if-ne v5, v3, :cond_7d

    return-object v3

    :goto_fc
    invoke-virtual {v12, v10}, Lt3/b;->i(Lt3/d;)V

    throw v0
.end method

.method public final d(Ljava/lang/Object;)Z
    .registers 2

    invoke-virtual {p0, p1}, Ls3/q0;->k(Ljava/lang/Object;)V

    const/4 p1, 0x1

    return p1
.end method

.method public final e(Lz2/j;ILr3/a;)Ls3/e;
    .registers 5

    if-ltz p2, :cond_6

    const/4 v0, 0x2

    if-ge p2, v0, :cond_6

    goto :goto_9

    :cond_6
    const/4 v0, -0x2

    if-ne p2, v0, :cond_f

    :goto_9
    sget-object v0, Lr3/a;->d:Lr3/a;

    if-ne p3, v0, :cond_f

    :goto_d
    move-object v0, p0

    goto :goto_1e

    :cond_f
    if-eqz p2, :cond_14

    const/4 v0, -0x3

    if-ne p2, v0, :cond_19

    :cond_14
    sget-object v0, Lr3/a;->c:Lr3/a;

    if-ne p3, v0, :cond_19

    goto :goto_d

    :cond_19
    new-instance v0, Lt3/j;

    invoke-direct {v0, p2, p1, p3, p0}, Lt3/i;-><init>(ILz2/j;Lr3/a;Ls3/e;)V

    :goto_1e
    return-object v0
.end method

.method public final g()Lt3/d;
    .registers 2

    new-instance v0, Ls3/r0;

    invoke-direct {v0}, Ls3/r0;-><init>()V

    return-object v0
.end method

.method public final getValue()Ljava/lang/Object;
    .registers 3

    sget-object v0, Lt3/c;->b:Lu0/t;

    sget-object v1, Ls3/q0;->h:Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;

    invoke-virtual {v1, p0}, Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_b

    const/4 v1, 0x0

    :cond_b
    return-object v1
.end method

.method public final h()[Lt3/d;
    .registers 2

    const/4 v0, 0x2

    new-array v0, v0, [Ls3/r0;

    return-object v0
.end method

.method public final k(Ljava/lang/Object;)V
    .registers 10

    if-nez p1, :cond_4

    sget-object p1, Lt3/c;->b:Lu0/t;

    :cond_4
    monitor-enter p0

    :try_start_5
    sget-object v0, Ls3/q0;->h:Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;

    invoke-virtual {v0, p0}, Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1, p1}, Ld3/b;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1
    :try_end_f
    .catchall {:try_start_5 .. :try_end_f} :catchall_7e

    if-eqz v1, :cond_14

    monitor-exit p0

    goto/16 :goto_85

    :cond_14
    :try_start_14
    invoke-virtual {v0, p0, p1}, Ljava/util/concurrent/atomic/AtomicReferenceFieldUpdater;->set(Ljava/lang/Object;Ljava/lang/Object;)V

    iget p1, p0, Ls3/q0;->g:I

    and-int/lit8 v0, p1, 0x1

    if-nez v0, :cond_80

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ls3/q0;->g:I

    iget-object v0, p0, Lt3/b;->c:[Lt3/d;
    :try_end_23
    .catchall {:try_start_14 .. :try_end_23} :catchall_7e

    monitor-exit p0

    :goto_24
    check-cast v0, [Ls3/r0;

    if-eqz v0, :cond_68

    array-length v1, v0

    const/4 v2, 0x0

    :goto_2a
    if-ge v2, v1, :cond_68

    aget-object v3, v0, v2

    if-eqz v3, :cond_65

    iget-object v3, v3, Ls3/r0;->a:Ljava/util/concurrent/atomic/AtomicReference;

    :goto_32
    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v4

    if-nez v4, :cond_39

    goto :goto_65

    :cond_39
    sget-object v5, Ls3/b0;->c:Lu0/t;

    if-ne v4, v5, :cond_3e

    goto :goto_65

    :cond_3e
    sget-object v6, Ls3/b0;->b:Lu0/t;

    if-ne v4, v6, :cond_50

    :cond_42
    invoke-virtual {v3, v4, v5}, Ljava/util/concurrent/atomic/AtomicReference;->compareAndSet(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_49

    goto :goto_65

    :cond_49
    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v6

    if-eq v6, v4, :cond_42

    goto :goto_32

    :cond_50
    invoke-virtual {v3, v4, v6}, Ljava/util/concurrent/atomic/AtomicReference;->compareAndSet(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_5e

    check-cast v4, Lp3/g;

    sget-object v3, Lw2/i;->a:Lw2/i;

    invoke-virtual {v4, v3}, Lp3/g;->resumeWith(Ljava/lang/Object;)V

    goto :goto_65

    :cond_5e
    invoke-virtual {v3}, Ljava/util/concurrent/atomic/AtomicReference;->get()Ljava/lang/Object;

    move-result-object v5

    if-eq v5, v4, :cond_50

    goto :goto_32

    :cond_65
    :goto_65
    add-int/lit8 v2, v2, 0x1

    goto :goto_2a

    :cond_68
    monitor-enter p0

    :try_start_69
    iget v0, p0, Ls3/q0;->g:I

    if-ne v0, p1, :cond_75

    add-int/lit8 p1, p1, 0x1

    iput p1, p0, Ls3/q0;->g:I
    :try_end_71
    .catchall {:try_start_69 .. :try_end_71} :catchall_73

    monitor-exit p0

    goto :goto_85

    :catchall_73
    move-exception p1

    goto :goto_7c

    :cond_75
    :try_start_75
    iget-object p1, p0, Lt3/b;->c:[Lt3/d;
    :try_end_77
    .catchall {:try_start_75 .. :try_end_77} :catchall_73

    monitor-exit p0

    move v7, v0

    move-object v0, p1

    move p1, v7

    goto :goto_24

    :goto_7c
    monitor-exit p0

    throw p1

    :catchall_7e
    move-exception p1

    goto :goto_86

    :cond_80
    add-int/lit8 p1, p1, 0x2

    :try_start_82
    iput p1, p0, Ls3/q0;->g:I
    :try_end_84
    .catchall {:try_start_82 .. :try_end_84} :catchall_7e

    monitor-exit p0

    :goto_85
    return-void

    :goto_86
    monitor-exit p0

    throw p1
.end method

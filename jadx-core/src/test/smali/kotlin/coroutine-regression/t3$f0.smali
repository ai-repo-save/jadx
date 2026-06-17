.class public final Lt3/f0;
.super Lt3/b;
.source "SourceFile"

# interfaces
.implements Ls3/o0;
.implements Ls3/w;
.implements Ls3/e;
.implements Lt3/w;


# instance fields
.field public final g:I

.field public final h:I

.field public final i:Lr3/a;

.field public j:[Ljava/lang/Object;

.field public k:J

.field public l:J

.field public m:I

.field public n:I


# direct methods
.method public constructor <init>(I)V
    .registers 4

    sget-object v0, Lr3/a;->d:Lr3/a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v1, 0x1

    iput v1, p0, Lt3/f0;->g:I

    const v1, 0x7fffffff

    iput v1, p0, Lt3/f0;->h:I

    iput-object v0, p0, Lt3/f0;->i:Lr3/a;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p0, p1}, Lt3/f0;->d(Ljava/lang/Object;)Z

    return-void
.end method

.method public static m(Lt3/f0;Ls3/f;Lz2/e;)V
    .registers 11

    instance-of v0, p2, Ls3/a0;

    if-eqz v0, :cond_13

    move-object v0, p2

    check-cast v0, Ls3/a0;

    iget v1, v0, Ls3/a0;->i:I

    const/high16 v2, -0x80000000

    and-int v3, v1, v2

    if-eqz v3, :cond_13

    sub-int/2addr v1, v2

    iput v1, v0, Ls3/a0;->i:I

    goto :goto_18

    :cond_13
    new-instance v0, Ls3/a0;

    invoke-direct {v0, p0, p2}, Ls3/a0;-><init>(Lt3/f0;Lz2/e;)V

    :goto_18
    iget-object p2, v0, Ls3/a0;->g:Ljava/lang/Object;

    sget-object v1, La3/a;->c:La3/a;

    iget v2, v0, Ls3/a0;->i:I

    const/4 v3, 0x3

    const/4 v4, 0x2

    if-eqz v2, :cond_5e

    const/4 p0, 0x1

    if-eq v2, p0, :cond_4f

    if-eq v2, v4, :cond_43

    if-ne v2, v3, :cond_3b

    iget-object p0, v0, Ls3/a0;->f:Lp3/w0;

    iget-object p1, v0, Ls3/a0;->e:Ls3/c0;

    iget-object v2, v0, Ls3/a0;->d:Ls3/f;

    iget-object v5, v0, Ls3/a0;->c:Lt3/f0;

    :try_start_31
    invoke-static {p2}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_34
    .catchall {:try_start_31 .. :try_end_34} :catchall_38

    :cond_34
    move-object p2, v2

    move-object v2, p0

    move-object p0, v5

    goto :goto_76

    :catchall_38
    move-exception p0

    goto/16 :goto_b6

    :cond_3b
    new-instance p0, Ljava/lang/IllegalStateException;

    const-string p1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p0, p1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_43
    iget-object p0, v0, Ls3/a0;->f:Lp3/w0;

    iget-object p1, v0, Ls3/a0;->e:Ls3/c0;

    iget-object v2, v0, Ls3/a0;->d:Ls3/f;

    iget-object v5, v0, Ls3/a0;->c:Lt3/f0;

    :try_start_4b
    invoke-static {p2}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_4e
    .catchall {:try_start_4b .. :try_end_4e} :catchall_38

    goto :goto_79

    :cond_4f
    iget-object p1, v0, Ls3/a0;->e:Ls3/c0;

    iget-object p0, v0, Ls3/a0;->d:Ls3/f;

    iget-object v2, v0, Ls3/a0;->c:Lt3/f0;

    :try_start_55
    invoke-static {p2}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_58
    .catchall {:try_start_55 .. :try_end_58} :catchall_5b

    move-object p2, p0

    move-object p0, v2

    goto :goto_6a

    :catchall_5b
    move-exception p0

    move-object v5, v2

    goto :goto_b6

    :cond_5e
    invoke-static {p2}, Ld3/b;->Y1(Ljava/lang/Object;)V

    invoke-virtual {p0}, Lt3/b;->f()Lt3/d;

    move-result-object p2

    check-cast p2, Ls3/c0;

    move-object v7, p2

    move-object p2, p1

    move-object p1, v7

    :goto_6a
    :try_start_6a
    invoke-interface {v0}, Lz2/e;->getContext()Lz2/j;

    move-result-object v2

    sget-object v5, Lp3/t;->d:Lp3/t;

    invoke-interface {v2, v5}, Lz2/j;->g(Lz2/i;)Lz2/h;

    move-result-object v2

    check-cast v2, Lp3/w0;
    :try_end_76
    .catchall {:try_start_6a .. :try_end_76} :catchall_b3

    :goto_76
    move-object v5, p0

    move-object p0, v2

    move-object v2, p2

    :cond_79
    :goto_79
    :try_start_79
    invoke-virtual {v5, p1}, Lt3/f0;->v(Ls3/c0;)Ljava/lang/Object;

    move-result-object p2

    sget-object v6, Ls3/b0;->a:Lu0/t;

    if-ne p2, v6, :cond_92

    iput-object v5, v0, Ls3/a0;->c:Lt3/f0;

    iput-object v2, v0, Ls3/a0;->d:Ls3/f;

    iput-object p1, v0, Ls3/a0;->e:Ls3/c0;

    iput-object p0, v0, Ls3/a0;->f:Lp3/w0;

    iput v4, v0, Ls3/a0;->i:I

    invoke-virtual {v5, p1, v0}, Lt3/f0;->k(Ls3/c0;Ls3/a0;)Ljava/lang/Object;

    move-result-object p2

    if-ne p2, v1, :cond_79

    return-void

    :cond_92
    if-eqz p0, :cond_a2

    invoke-interface {p0}, Lp3/w0;->b()Z

    move-result v6

    if-eqz v6, :cond_9b

    goto :goto_a2

    :cond_9b
    check-cast p0, Lp3/f1;

    invoke-virtual {p0}, Lp3/f1;->A()Ljava/util/concurrent/CancellationException;

    move-result-object p0

    throw p0

    :cond_a2
    :goto_a2
    iput-object v5, v0, Ls3/a0;->c:Lt3/f0;

    iput-object v2, v0, Ls3/a0;->d:Ls3/f;

    iput-object p1, v0, Ls3/a0;->e:Ls3/c0;

    iput-object p0, v0, Ls3/a0;->f:Lp3/w0;

    iput v3, v0, Ls3/a0;->i:I

    invoke-interface {v2, p2, v0}, Ls3/f;->b(Ljava/lang/Object;Lz2/e;)Ljava/lang/Object;

    move-result-object p2
    :try_end_b0
    .catchall {:try_start_79 .. :try_end_b0} :catchall_38

    if-ne p2, v1, :cond_34

    return-void

    :catchall_b3
    move-exception p2

    move-object v5, p0

    move-object p0, p2

    :goto_b6
    invoke-virtual {v5, p1}, Lt3/b;->i(Lt3/d;)V

    throw p0
.end method


# virtual methods
.method public final a()V
    .registers 14

    monitor-enter p0

    :try_start_1
    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v0

    iget v2, p0, Lt3/f0;->m:I

    int-to-long v2, v2

    add-long v5, v0, v2

    iget-wide v7, p0, Lt3/f0;->l:J

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v0

    iget v2, p0, Lt3/f0;->m:I

    int-to-long v2, v2

    add-long v9, v0, v2

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v0

    iget v2, p0, Lt3/f0;->m:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    iget v2, p0, Lt3/f0;->n:I

    int-to-long v2, v2

    add-long v11, v0, v2

    move-object v4, p0

    invoke-virtual/range {v4 .. v12}, Lt3/f0;->w(JJJJ)V
    :try_end_26
    .catchall {:try_start_1 .. :try_end_26} :catchall_28

    monitor-exit p0

    return-void

    :catchall_28
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final b(Ljava/lang/Object;Lz2/e;)Ljava/lang/Object;
    .registers 12

    invoke-virtual {p0, p1}, Lt3/f0;->d(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_a

    sget-object p1, Lw2/i;->a:Lw2/i;

    goto/16 :goto_7f

    :cond_a
    new-instance v6, Lp3/g;

    invoke-static {p2}, Ld3/b;->E0(Lz2/e;)Lz2/e;

    move-result-object p2

    const/4 v7, 0x1

    invoke-direct {v6, v7, p2}, Lp3/g;-><init>(ILz2/e;)V

    invoke-virtual {v6}, Lp3/g;->r()V

    sget-object p2, Lt3/c;->a:[Lz2/e;

    monitor-enter p0

    :try_start_1a
    invoke-virtual {p0, p1}, Lt3/f0;->t(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2d

    sget-object p1, Lw2/i;->a:Lw2/i;

    invoke-virtual {v6, p1}, Lp3/g;->resumeWith(Ljava/lang/Object;)V

    invoke-virtual {p0, p2}, Lt3/f0;->p([Lz2/e;)[Lz2/e;

    move-result-object p1

    const/4 p2, 0x0

    goto :goto_53

    :catchall_2b
    move-exception p1

    goto :goto_80

    :cond_2d
    new-instance v8, Ls3/z;

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v0

    iget v2, p0, Lt3/f0;->m:I

    iget v3, p0, Lt3/f0;->n:I

    add-int/2addr v2, v3

    int-to-long v2, v2

    add-long/2addr v2, v0

    move-object v0, v8

    move-object v1, p0

    move-object v4, p1

    move-object v5, v6

    invoke-direct/range {v0 .. v5}, Ls3/z;-><init>(Lt3/f0;JLjava/lang/Object;Lp3/g;)V

    invoke-virtual {p0, v8}, Lt3/f0;->o(Ljava/lang/Object;)V

    iget p1, p0, Lt3/f0;->n:I

    add-int/2addr p1, v7

    iput p1, p0, Lt3/f0;->n:I

    iget p1, p0, Lt3/f0;->h:I

    if-nez p1, :cond_51

    invoke-virtual {p0, p2}, Lt3/f0;->p([Lz2/e;)[Lz2/e;

    move-result-object p2
    :try_end_51
    .catchall {:try_start_1a .. :try_end_51} :catchall_2b

    :cond_51
    move-object p1, p2

    move-object p2, v8

    :goto_53
    monitor-exit p0

    if-eqz p2, :cond_5f

    new-instance v0, Lp3/d;

    const/4 v1, 0x2

    invoke-direct {v0, v1, p2}, Lp3/d;-><init>(ILjava/lang/Object;)V

    invoke-static {v6, v0}, Ld3/b;->F0(Lp3/f;Lp3/d;)V

    :cond_5f
    array-length p2, p1

    const/4 v0, 0x0

    :goto_61
    if-ge v0, p2, :cond_6f

    aget-object v1, p1, v0

    if-eqz v1, :cond_6c

    sget-object v2, Lw2/i;->a:Lw2/i;

    invoke-interface {v1, v2}, Lz2/e;->resumeWith(Ljava/lang/Object;)V

    :cond_6c
    add-int/lit8 v0, v0, 0x1

    goto :goto_61

    :cond_6f
    invoke-virtual {v6}, Lp3/g;->q()Ljava/lang/Object;

    move-result-object p1

    sget-object p2, La3/a;->c:La3/a;

    if-ne p1, p2, :cond_78

    goto :goto_7a

    :cond_78
    sget-object p1, Lw2/i;->a:Lw2/i;

    :goto_7a
    if-ne p1, p2, :cond_7d

    goto :goto_7f

    :cond_7d
    sget-object p1, Lw2/i;->a:Lw2/i;

    :goto_7f
    return-object p1

    :goto_80
    monitor-exit p0

    throw p1
.end method

.method public final c(Ls3/f;Lz2/e;)Ljava/lang/Object;
    .registers 3

    invoke-static {p0, p1, p2}, Lt3/f0;->m(Lt3/f0;Ls3/f;Lz2/e;)V

    sget-object p1, La3/a;->c:La3/a;

    return-object p1
.end method

.method public final d(Ljava/lang/Object;)Z
    .registers 7

    sget-object v0, Lt3/c;->a:[Lz2/e;

    monitor-enter p0

    :try_start_3
    invoke-virtual {p0, p1}, Lt3/f0;->t(Ljava/lang/Object;)Z

    move-result p1

    const/4 v1, 0x0

    if-eqz p1, :cond_12

    invoke-virtual {p0, v0}, Lt3/f0;->p([Lz2/e;)[Lz2/e;

    move-result-object v0
    :try_end_e
    .catchall {:try_start_3 .. :try_end_e} :catchall_10

    const/4 p1, 0x1

    goto :goto_13

    :catchall_10
    move-exception p1

    goto :goto_24

    :cond_12
    move p1, v1

    :goto_13
    monitor-exit p0

    array-length v2, v0

    :goto_15
    if-ge v1, v2, :cond_23

    aget-object v3, v0, v1

    if-eqz v3, :cond_20

    sget-object v4, Lw2/i;->a:Lw2/i;

    invoke-interface {v3, v4}, Lz2/e;->resumeWith(Ljava/lang/Object;)V

    :cond_20
    add-int/lit8 v1, v1, 0x1

    goto :goto_15

    :cond_23
    return p1

    :goto_24
    monitor-exit p0

    throw p1
.end method

.method public final e(Lz2/j;ILr3/a;)Ls3/e;
    .registers 5

    if-eqz p2, :cond_5

    const/4 v0, -0x3

    if-ne p2, v0, :cond_b

    :cond_5
    sget-object v0, Lr3/a;->c:Lr3/a;

    if-ne p3, v0, :cond_b

    move-object v0, p0

    goto :goto_10

    :cond_b
    new-instance v0, Lt3/j;

    invoke-direct {v0, p2, p1, p3, p0}, Lt3/i;-><init>(ILz2/j;Lr3/a;Ls3/e;)V

    :goto_10
    return-object v0
.end method

.method public final g()Lt3/d;
    .registers 4

    new-instance v0, Ls3/c0;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v1, -0x1

    iput-wide v1, v0, Ls3/c0;->a:J

    return-object v0
.end method

.method public final getValue()Ljava/lang/Object;
    .registers 8

    monitor-enter p0

    :try_start_1
    iget-object v0, p0, Lt3/f0;->j:[Ljava/lang/Object;

    invoke-static {v0}, Ld3/b;->A(Ljava/lang/Object;)V

    iget-wide v1, p0, Lt3/f0;->k:J

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v3

    iget v5, p0, Lt3/f0;->m:I

    int-to-long v5, v5

    add-long/2addr v3, v5

    iget-wide v5, p0, Lt3/f0;->k:J

    sub-long/2addr v3, v5

    long-to-int v3, v3

    int-to-long v3, v3

    add-long/2addr v1, v3

    const-wide/16 v3, 0x1

    sub-long/2addr v1, v3

    long-to-int v1, v1

    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    and-int/2addr v1, v2

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0
    :try_end_2a
    .catchall {:try_start_1 .. :try_end_2a} :catchall_2c

    monitor-exit p0

    return-object v0

    :catchall_2c
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final h()[Lt3/d;
    .registers 2

    const/4 v0, 0x2

    new-array v0, v0, [Ls3/c0;

    return-object v0
.end method

.method public final k(Ls3/c0;Ls3/a0;)Ljava/lang/Object;
    .registers 8

    new-instance v0, Lp3/g;

    invoke-static {p2}, Ld3/b;->E0(Lz2/e;)Lz2/e;

    move-result-object p2

    const/4 v1, 0x1

    invoke-direct {v0, v1, p2}, Lp3/g;-><init>(ILz2/e;)V

    invoke-virtual {v0}, Lp3/g;->r()V

    monitor-enter p0

    :try_start_e
    invoke-virtual {p0, p1}, Lt3/f0;->u(Ls3/c0;)J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long p2, v1, v3

    if-gez p2, :cond_1b

    iput-object v0, p1, Ls3/c0;->b:Lp3/g;

    goto :goto_20

    :cond_1b
    sget-object p1, Lw2/i;->a:Lw2/i;

    invoke-virtual {v0, p1}, Lp3/g;->resumeWith(Ljava/lang/Object;)V
    :try_end_20
    .catchall {:try_start_e .. :try_end_20} :catchall_2d

    :goto_20
    monitor-exit p0

    invoke-virtual {v0}, Lp3/g;->q()Ljava/lang/Object;

    move-result-object p1

    sget-object p2, La3/a;->c:La3/a;

    if-ne p1, p2, :cond_2a

    goto :goto_2c

    :cond_2a
    sget-object p1, Lw2/i;->a:Lw2/i;

    :goto_2c
    return-object p1

    :catchall_2d
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final l()V
    .registers 9

    iget v0, p0, Lt3/f0;->h:I

    const/4 v1, 0x1

    if-nez v0, :cond_a

    iget v0, p0, Lt3/f0;->n:I

    if-gt v0, v1, :cond_a

    goto :goto_3f

    :cond_a
    iget-object v0, p0, Lt3/f0;->j:[Ljava/lang/Object;

    invoke-static {v0}, Ld3/b;->A(Ljava/lang/Object;)V

    :goto_f
    iget v2, p0, Lt3/f0;->n:I

    if-lez v2, :cond_3f

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v2

    iget v4, p0, Lt3/f0;->m:I

    iget v5, p0, Lt3/f0;->n:I

    add-int/2addr v4, v5

    int-to-long v6, v4

    add-long/2addr v2, v6

    const-wide/16 v6, 0x1

    sub-long/2addr v2, v6

    long-to-int v2, v2

    array-length v3, v0

    sub-int/2addr v3, v1

    and-int/2addr v2, v3

    aget-object v2, v0, v2

    sget-object v3, Ls3/b0;->a:Lu0/t;

    if-ne v2, v3, :cond_3f

    add-int/lit8 v5, v5, -0x1

    iput v5, p0, Lt3/f0;->n:I

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v2

    iget v4, p0, Lt3/f0;->m:I

    iget v5, p0, Lt3/f0;->n:I

    add-int/2addr v4, v5

    int-to-long v4, v4

    add-long/2addr v2, v4

    const/4 v4, 0x0

    invoke-static {v0, v2, v3, v4}, Ls3/b0;->a([Ljava/lang/Object;JLjava/lang/Object;)V

    goto :goto_f

    :cond_3f
    :goto_3f
    return-void
.end method

.method public final n()V
    .registers 11

    iget-object v0, p0, Lt3/f0;->j:[Ljava/lang/Object;

    invoke-static {v0}, Ld3/b;->A(Ljava/lang/Object;)V

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v1

    const/4 v3, 0x0

    invoke-static {v0, v1, v2, v3}, Ls3/b0;->a([Ljava/lang/Object;JLjava/lang/Object;)V

    iget v0, p0, Lt3/f0;->m:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lt3/f0;->m:I

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v0

    const-wide/16 v2, 0x1

    add-long/2addr v0, v2

    iget-wide v2, p0, Lt3/f0;->k:J

    cmp-long v2, v2, v0

    if-gez v2, :cond_22

    iput-wide v0, p0, Lt3/f0;->k:J

    :cond_22
    iget-wide v2, p0, Lt3/f0;->l:J

    cmp-long v2, v2, v0

    if-gez v2, :cond_4d

    iget v2, p0, Lt3/b;->d:I

    if-eqz v2, :cond_4b

    iget-object v2, p0, Lt3/b;->c:[Lt3/d;

    if-eqz v2, :cond_4b

    array-length v3, v2

    const/4 v4, 0x0

    :goto_32
    if-ge v4, v3, :cond_4b

    aget-object v5, v2, v4

    if-eqz v5, :cond_48

    check-cast v5, Ls3/c0;

    iget-wide v6, v5, Ls3/c0;->a:J

    const-wide/16 v8, 0x0

    cmp-long v8, v6, v8

    if-ltz v8, :cond_48

    cmp-long v6, v6, v0

    if-gez v6, :cond_48

    iput-wide v0, v5, Ls3/c0;->a:J

    :cond_48
    add-int/lit8 v4, v4, 0x1

    goto :goto_32

    :cond_4b
    iput-wide v0, p0, Lt3/f0;->l:J

    :cond_4d
    return-void
.end method

.method public final o(Ljava/lang/Object;)V
    .registers 8

    iget v0, p0, Lt3/f0;->m:I

    iget v1, p0, Lt3/f0;->n:I

    add-int/2addr v0, v1

    iget-object v1, p0, Lt3/f0;->j:[Ljava/lang/Object;

    const/4 v2, 0x2

    if-nez v1, :cond_11

    const/4 v1, 0x0

    const/4 v3, 0x0

    invoke-virtual {p0, v3, v2, v1}, Lt3/f0;->r(II[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    goto :goto_1a

    :cond_11
    array-length v3, v1

    if-lt v0, v3, :cond_1a

    array-length v3, v1

    mul-int/2addr v3, v2

    invoke-virtual {p0, v0, v3, v1}, Lt3/f0;->r(II[Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    :cond_1a
    :goto_1a
    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v2

    int-to-long v4, v0

    add-long/2addr v2, v4

    invoke-static {v1, v2, v3, p1}, Ls3/b0;->a([Ljava/lang/Object;JLjava/lang/Object;)V

    return-void
.end method

.method public final p([Lz2/e;)[Lz2/e;
    .registers 12

    array-length v0, p1

    iget v1, p0, Lt3/b;->d:I

    if-eqz v1, :cond_43

    iget-object v1, p0, Lt3/b;->c:[Lt3/d;

    if-eqz v1, :cond_43

    array-length v2, v1

    const/4 v3, 0x0

    :goto_b
    if-ge v3, v2, :cond_43

    aget-object v4, v1, v3

    if-eqz v4, :cond_40

    check-cast v4, Ls3/c0;

    iget-object v5, v4, Ls3/c0;->b:Lp3/g;

    if-nez v5, :cond_18

    goto :goto_40

    :cond_18
    invoke-virtual {p0, v4}, Lt3/f0;->u(Ls3/c0;)J

    move-result-wide v6

    const-wide/16 v8, 0x0

    cmp-long v6, v6, v8

    if-ltz v6, :cond_40

    array-length v6, p1

    if-lt v0, v6, :cond_35

    array-length v6, p1

    const/4 v7, 0x2

    mul-int/2addr v6, v7

    invoke-static {v7, v6}, Ljava/lang/Math;->max(II)I

    move-result v6

    invoke-static {p1, v6}, Ljava/util/Arrays;->copyOf([Ljava/lang/Object;I)[Ljava/lang/Object;

    move-result-object p1

    const-string v6, "copyOf(...)"

    invoke-static {p1, v6}, Ld3/b;->D(Ljava/lang/Object;Ljava/lang/String;)V

    :cond_35
    move-object v6, p1

    check-cast v6, [Lz2/e;

    add-int/lit8 v7, v0, 0x1

    aput-object v5, v6, v0

    const/4 v0, 0x0

    iput-object v0, v4, Ls3/c0;->b:Lp3/g;

    move v0, v7

    :cond_40
    :goto_40
    add-int/lit8 v3, v3, 0x1

    goto :goto_b

    :cond_43
    check-cast p1, [Lz2/e;

    return-object p1
.end method

.method public final q()J
    .registers 5

    iget-wide v0, p0, Lt3/f0;->l:J

    iget-wide v2, p0, Lt3/f0;->k:J

    invoke-static {v0, v1, v2, v3}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    return-wide v0
.end method

.method public final r(II[Ljava/lang/Object;)[Ljava/lang/Object;
    .registers 11

    if-lez p2, :cond_20

    new-array p2, p2, [Ljava/lang/Object;

    iput-object p2, p0, Lt3/f0;->j:[Ljava/lang/Object;

    if-nez p3, :cond_9

    goto :goto_1f

    :cond_9
    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v0

    const/4 v2, 0x0

    :goto_e
    if-ge v2, p1, :cond_1f

    int-to-long v3, v2

    add-long/2addr v3, v0

    long-to-int v5, v3

    array-length v6, p3

    add-int/lit8 v6, v6, -0x1

    and-int/2addr v5, v6

    aget-object v5, p3, v5

    invoke-static {p2, v3, v4, v5}, Ls3/b0;->a([Ljava/lang/Object;JLjava/lang/Object;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_e

    :cond_1f
    :goto_1f
    return-object p2

    :cond_20
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string p2, "Buffer size overflow"

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-direct {p1, p2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1
.end method

.method public final s(I)V
    .registers 9

    monitor-enter p0

    :try_start_1
    iget-object v0, p0, Lt3/f0;->j:[Ljava/lang/Object;

    invoke-static {v0}, Ld3/b;->A(Ljava/lang/Object;)V

    iget-wide v1, p0, Lt3/f0;->k:J

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v3

    iget v5, p0, Lt3/f0;->m:I

    int-to-long v5, v5

    add-long/2addr v3, v5

    iget-wide v5, p0, Lt3/f0;->k:J

    sub-long/2addr v3, v5

    long-to-int v3, v3

    int-to-long v3, v3

    add-long/2addr v1, v3

    const-wide/16 v3, 0x1

    sub-long/2addr v1, v3

    long-to-int v1, v1

    array-length v2, v0

    add-int/lit8 v2, v2, -0x1

    and-int/2addr v1, v2

    aget-object v0, v0, v1

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->intValue()I

    move-result v0

    add-int/2addr v0, p1

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p0, p1}, Lt3/f0;->d(Ljava/lang/Object;)Z
    :try_end_2e
    .catchall {:try_start_1 .. :try_end_2e} :catchall_30

    monitor-exit p0

    return-void

    :catchall_30
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final t(Ljava/lang/Object;)Z
    .registers 14

    iget v0, p0, Lt3/b;->d:I

    iget v1, p0, Lt3/f0;->g:I

    const/4 v9, 0x1

    if-nez v0, :cond_22

    if-nez v1, :cond_a

    goto :goto_77

    :cond_a
    invoke-virtual {p0, p1}, Lt3/f0;->o(Ljava/lang/Object;)V

    iget v0, p0, Lt3/f0;->m:I

    add-int/2addr v0, v9

    iput v0, p0, Lt3/f0;->m:I

    if-le v0, v1, :cond_17

    invoke-virtual {p0}, Lt3/f0;->n()V

    :cond_17
    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v0

    iget v2, p0, Lt3/f0;->m:I

    int-to-long v2, v2

    add-long/2addr v0, v2

    iput-wide v0, p0, Lt3/f0;->l:J

    goto :goto_77

    :cond_22
    iget v0, p0, Lt3/f0;->m:I

    iget v2, p0, Lt3/f0;->h:I

    if-lt v0, v2, :cond_3e

    iget-wide v3, p0, Lt3/f0;->l:J

    iget-wide v5, p0, Lt3/f0;->k:J

    cmp-long v0, v3, v5

    if-gtz v0, :cond_3e

    iget-object v0, p0, Lt3/f0;->i:Lr3/a;

    invoke-virtual {v0}, Ljava/lang/Enum;->ordinal()I

    move-result v0

    if-eqz v0, :cond_3c

    const/4 v3, 0x2

    if-eq v0, v3, :cond_77

    goto :goto_3e

    :cond_3c
    const/4 v9, 0x0

    goto :goto_77

    :cond_3e
    :goto_3e
    invoke-virtual {p0, p1}, Lt3/f0;->o(Ljava/lang/Object;)V

    iget v0, p0, Lt3/f0;->m:I

    add-int/2addr v0, v9

    iput v0, p0, Lt3/f0;->m:I

    if-le v0, v2, :cond_4b

    invoke-virtual {p0}, Lt3/f0;->n()V

    :cond_4b
    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v2

    iget v0, p0, Lt3/f0;->m:I

    int-to-long v4, v0

    add-long/2addr v2, v4

    iget-wide v4, p0, Lt3/f0;->k:J

    sub-long/2addr v2, v4

    long-to-int v0, v2

    if-le v0, v1, :cond_77

    const-wide/16 v0, 0x1

    add-long v1, v4, v0

    iget-wide v3, p0, Lt3/f0;->l:J

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v5

    iget v0, p0, Lt3/f0;->m:I

    int-to-long v7, v0

    add-long/2addr v5, v7

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v7

    iget v0, p0, Lt3/f0;->m:I

    int-to-long v10, v0

    add-long/2addr v7, v10

    iget v0, p0, Lt3/f0;->n:I

    int-to-long v10, v0

    add-long/2addr v7, v10

    move-object v0, p0

    invoke-virtual/range {v0 .. v8}, Lt3/f0;->w(JJJJ)V

    :cond_77
    :goto_77
    return v9
.end method

.method public final u(Ls3/c0;)J
    .registers 8

    iget-wide v0, p1, Ls3/c0;->a:J

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v2

    iget p1, p0, Lt3/f0;->m:I

    int-to-long v4, p1

    add-long/2addr v2, v4

    cmp-long p1, v0, v2

    if-gez p1, :cond_f

    goto :goto_25

    :cond_f
    iget p1, p0, Lt3/f0;->h:I

    const-wide/16 v2, -0x1

    if-lez p1, :cond_17

    :goto_15
    move-wide v0, v2

    goto :goto_25

    :cond_17
    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v4

    cmp-long p1, v0, v4

    if-lez p1, :cond_20

    goto :goto_15

    :cond_20
    iget p1, p0, Lt3/f0;->n:I

    if-nez p1, :cond_25

    goto :goto_15

    :cond_25
    :goto_25
    return-wide v0
.end method

.method public final v(Ls3/c0;)Ljava/lang/Object;
    .registers 10

    sget-object v0, Lt3/c;->a:[Lz2/e;

    monitor-enter p0

    :try_start_3
    invoke-virtual {p0, p1}, Lt3/f0;->u(Ls3/c0;)J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v3, v1, v3

    if-gez v3, :cond_10

    sget-object p1, Ls3/b0;->a:Lu0/t;

    goto :goto_32

    :cond_10
    iget-wide v3, p1, Ls3/c0;->a:J

    iget-object v0, p0, Lt3/f0;->j:[Ljava/lang/Object;

    invoke-static {v0}, Ld3/b;->A(Ljava/lang/Object;)V

    long-to-int v5, v1

    array-length v6, v0

    add-int/lit8 v6, v6, -0x1

    and-int/2addr v5, v6

    aget-object v0, v0, v5

    instance-of v5, v0, Ls3/z;

    if-eqz v5, :cond_26

    check-cast v0, Ls3/z;

    iget-object v0, v0, Ls3/z;->e:Ljava/lang/Object;

    :cond_26
    const-wide/16 v5, 0x1

    add-long/2addr v1, v5

    iput-wide v1, p1, Ls3/c0;->a:J

    invoke-virtual {p0, v3, v4}, Lt3/f0;->x(J)[Lz2/e;

    move-result-object p1
    :try_end_2f
    .catchall {:try_start_3 .. :try_end_2f} :catchall_44

    move-object v7, v0

    move-object v0, p1

    move-object p1, v7

    :goto_32
    monitor-exit p0

    array-length v1, v0

    const/4 v2, 0x0

    :goto_35
    if-ge v2, v1, :cond_43

    aget-object v3, v0, v2

    if-eqz v3, :cond_40

    sget-object v4, Lw2/i;->a:Lw2/i;

    invoke-interface {v3, v4}, Lz2/e;->resumeWith(Ljava/lang/Object;)V

    :cond_40
    add-int/lit8 v2, v2, 0x1

    goto :goto_35

    :cond_43
    return-object p1

    :catchall_44
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method public final w(JJJJ)V
    .registers 15

    invoke-static {p3, p4, p1, p2}, Ljava/lang/Math;->min(JJ)J

    move-result-wide v0

    invoke-virtual {p0}, Lt3/f0;->q()J

    move-result-wide v2

    :goto_8
    cmp-long v4, v2, v0

    if-gez v4, :cond_19

    iget-object v4, p0, Lt3/f0;->j:[Ljava/lang/Object;

    invoke-static {v4}, Ld3/b;->A(Ljava/lang/Object;)V

    const/4 v5, 0x0

    invoke-static {v4, v2, v3, v5}, Ls3/b0;->a([Ljava/lang/Object;JLjava/lang/Object;)V

    const-wide/16 v4, 0x1

    add-long/2addr v2, v4

    goto :goto_8

    :cond_19
    iput-wide p1, p0, Lt3/f0;->k:J

    iput-wide p3, p0, Lt3/f0;->l:J

    sub-long p1, p5, v0

    long-to-int p1, p1

    iput p1, p0, Lt3/f0;->m:I

    sub-long/2addr p7, p5

    long-to-int p1, p7

    iput p1, p0, Lt3/f0;->n:I

    return-void
.end method

.method public final x(J)[Lz2/e;
    .registers 25

    move-object/from16 v9, p0

    iget-wide v0, v9, Lt3/f0;->l:J

    cmp-long v0, p1, v0

    sget-object v1, Lt3/c;->a:[Lz2/e;

    if-lez v0, :cond_c

    goto/16 :goto_10f

    :cond_c
    invoke-virtual/range {p0 .. p0}, Lt3/f0;->q()J

    move-result-wide v2

    iget v0, v9, Lt3/f0;->m:I

    int-to-long v4, v0

    add-long/2addr v4, v2

    iget v0, v9, Lt3/f0;->h:I

    const-wide/16 v6, 0x1

    if-nez v0, :cond_1f

    iget v8, v9, Lt3/f0;->n:I

    if-lez v8, :cond_1f

    add-long/2addr v4, v6

    :cond_1f
    iget v8, v9, Lt3/b;->d:I

    if-eqz v8, :cond_41

    iget-object v8, v9, Lt3/b;->c:[Lt3/d;

    if-eqz v8, :cond_41

    array-length v11, v8

    const/4 v12, 0x0

    :goto_29
    if-ge v12, v11, :cond_41

    aget-object v13, v8, v12

    if-eqz v13, :cond_3e

    check-cast v13, Ls3/c0;

    iget-wide v13, v13, Ls3/c0;->a:J

    const-wide/16 v15, 0x0

    cmp-long v15, v13, v15

    if-ltz v15, :cond_3e

    cmp-long v15, v13, v4

    if-gez v15, :cond_3e

    move-wide v4, v13

    :cond_3e
    add-int/lit8 v12, v12, 0x1

    goto :goto_29

    :cond_41
    iget-wide v11, v9, Lt3/f0;->l:J

    cmp-long v8, v4, v11

    if-gtz v8, :cond_49

    goto/16 :goto_10f

    :cond_49
    invoke-virtual/range {p0 .. p0}, Lt3/f0;->q()J

    move-result-wide v11

    iget v8, v9, Lt3/f0;->m:I

    int-to-long v13, v8

    add-long/2addr v11, v13

    iget v8, v9, Lt3/b;->d:I

    if-lez v8, :cond_61

    sub-long v13, v11, v4

    long-to-int v8, v13

    iget v13, v9, Lt3/f0;->n:I

    sub-int v8, v0, v8

    invoke-static {v13, v8}, Ljava/lang/Math;->min(II)I

    move-result v8

    goto :goto_63

    :cond_61
    iget v8, v9, Lt3/f0;->n:I

    :goto_63
    iget v13, v9, Lt3/f0;->n:I

    int-to-long v13, v13

    add-long/2addr v13, v11

    sget-object v15, Ls3/b0;->a:Lu0/t;

    const/16 v16, 0x1

    if-lez v8, :cond_b7

    new-array v1, v8, [Lz2/e;

    iget-object v10, v9, Lt3/f0;->j:[Ljava/lang/Object;

    invoke-static {v10}, Ld3/b;->A(Ljava/lang/Object;)V

    move-wide v6, v11

    const/16 v17, 0x0

    :goto_77
    cmp-long v18, v11, v13

    if-gez v18, :cond_b2

    move-wide/from16 v18, v4

    long-to-int v4, v11

    array-length v5, v10

    add-int/lit8 v5, v5, -0x1

    and-int/2addr v4, v5

    aget-object v4, v10, v4

    if-eq v4, v15, :cond_a8

    const-string v5, "null cannot be cast to non-null type kotlinx.coroutines.flow.SharedFlowImpl.Emitter"

    invoke-static {v4, v5}, Ld3/b;->B(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v4, Ls3/z;

    add-int/lit8 v5, v17, 0x1

    move-wide/from16 v20, v13

    iget-object v13, v4, Ls3/z;->f:Lz2/e;

    aput-object v13, v1, v17

    invoke-static {v10, v11, v12, v15}, Ls3/b0;->a([Ljava/lang/Object;JLjava/lang/Object;)V

    iget-object v4, v4, Ls3/z;->e:Ljava/lang/Object;

    invoke-static {v10, v6, v7, v4}, Ls3/b0;->a([Ljava/lang/Object;JLjava/lang/Object;)V

    const-wide/16 v13, 0x1

    add-long/2addr v6, v13

    if-ge v5, v8, :cond_a5

    move/from16 v17, v5

    goto :goto_ac

    :cond_a5
    :goto_a5
    move-object v10, v1

    move-wide v11, v6

    goto :goto_bc

    :cond_a8
    move-wide/from16 v20, v13

    const-wide/16 v13, 0x1

    :goto_ac
    add-long/2addr v11, v13

    move-wide/from16 v4, v18

    move-wide/from16 v13, v20

    goto :goto_77

    :cond_b2
    move-wide/from16 v18, v4

    move-wide/from16 v20, v13

    goto :goto_a5

    :cond_b7
    move-wide/from16 v18, v4

    move-wide/from16 v20, v13

    move-object v10, v1

    :goto_bc
    sub-long v1, v11, v2

    long-to-int v1, v1

    iget v2, v9, Lt3/b;->d:I

    if-nez v2, :cond_c5

    move-wide v3, v11

    goto :goto_c7

    :cond_c5
    move-wide/from16 v3, v18

    :goto_c7
    iget-wide v5, v9, Lt3/f0;->k:J

    iget v2, v9, Lt3/f0;->g:I

    invoke-static {v2, v1}, Ljava/lang/Math;->min(II)I

    move-result v1

    int-to-long v1, v1

    sub-long v1, v11, v1

    invoke-static {v5, v6, v1, v2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v1

    if-nez v0, :cond_f2

    cmp-long v0, v1, v20

    if-gez v0, :cond_f2

    iget-object v0, v9, Lt3/f0;->j:[Ljava/lang/Object;

    invoke-static {v0}, Ld3/b;->A(Ljava/lang/Object;)V

    long-to-int v5, v1

    array-length v6, v0

    add-int/lit8 v6, v6, -0x1

    and-int/2addr v5, v6

    aget-object v0, v0, v5

    invoke-static {v0, v15}, Ld3/b;->l(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_f2

    const-wide/16 v5, 0x1

    add-long/2addr v11, v5

    add-long/2addr v1, v5

    :cond_f2
    move-wide v5, v11

    move-object/from16 v0, p0

    move-wide/from16 v7, v20

    invoke-virtual/range {v0 .. v8}, Lt3/f0;->w(JJJJ)V

    invoke-virtual/range {p0 .. p0}, Lt3/f0;->l()V

    array-length v0, v10

    if-nez v0, :cond_103

    move/from16 v0, v16

    goto :goto_104

    :cond_103
    const/4 v0, 0x0

    :goto_104
    xor-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_10e

    invoke-virtual {v9, v10}, Lt3/f0;->p([Lz2/e;)[Lz2/e;

    move-result-object v0

    move-object v1, v0

    goto :goto_10f

    :cond_10e
    move-object v1, v10

    :goto_10f
    return-object v1
.end method

.class public final Landroidx/room/d;
.super Lb3/h;
.source "SourceFile"

# interfaces
.implements Lg3/p;


# instance fields
.field public d:Lr3/b;

.field public e:I

.field public final synthetic f:Landroidx/room/e0;

.field public final synthetic g:Landroidx/room/e;

.field public final synthetic h:Lr3/j;

.field public final synthetic i:Ljava/util/concurrent/Callable;

.field public final synthetic j:Lr3/j;


# direct methods
.method public constructor <init>(Landroidx/room/e0;Landroidx/room/e;Lr3/j;Ljava/util/concurrent/Callable;Lr3/j;Lz2/e;)V
    .registers 7

    iput-object p1, p0, Landroidx/room/d;->f:Landroidx/room/e0;

    iput-object p2, p0, Landroidx/room/d;->g:Landroidx/room/e;

    iput-object p3, p0, Landroidx/room/d;->h:Lr3/j;

    iput-object p4, p0, Landroidx/room/d;->i:Ljava/util/concurrent/Callable;

    iput-object p5, p0, Landroidx/room/d;->j:Lr3/j;

    const/4 p1, 0x2

    invoke-direct {p0, p1, p6}, Lb3/h;-><init>(ILz2/e;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lz2/e;)Lz2/e;
    .registers 10

    new-instance p1, Landroidx/room/d;

    iget-object v4, p0, Landroidx/room/d;->i:Ljava/util/concurrent/Callable;

    iget-object v5, p0, Landroidx/room/d;->j:Lr3/j;

    iget-object v1, p0, Landroidx/room/d;->f:Landroidx/room/e0;

    iget-object v2, p0, Landroidx/room/d;->g:Landroidx/room/e;

    iget-object v3, p0, Landroidx/room/d;->h:Lr3/j;

    move-object v0, p1

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Landroidx/room/d;-><init>(Landroidx/room/e0;Landroidx/room/e;Lr3/j;Ljava/util/concurrent/Callable;Lr3/j;Lz2/e;)V

    return-object p1
.end method

.method public final f(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .registers 3

    check-cast p1, Lp3/v;

    check-cast p2, Lz2/e;

    invoke-virtual {p0, p1, p2}, Landroidx/room/d;->create(Ljava/lang/Object;Lz2/e;)Lz2/e;

    move-result-object p1

    check-cast p1, Landroidx/room/d;

    sget-object p2, Lw2/i;->a:Lw2/i;

    invoke-virtual {p1, p2}, Landroidx/room/d;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .registers 10

    sget-object v0, La3/a;->c:La3/a;

    iget v1, p0, Landroidx/room/d;->e:I

    const/4 v2, 0x2

    const/4 v3, 0x1

    iget-object v4, p0, Landroidx/room/d;->g:Landroidx/room/e;

    iget-object v5, p0, Landroidx/room/d;->f:Landroidx/room/e0;

    if-eqz v1, :cond_27

    if-eq v1, v3, :cond_21

    if-ne v1, v2, :cond_19

    iget-object v1, p0, Landroidx/room/d;->d:Lr3/b;

    :try_start_12
    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_15
    .catchall {:try_start_12 .. :try_end_15} :catchall_17

    :cond_15
    move-object p1, v1

    goto :goto_37

    :catchall_17
    move-exception p1

    goto :goto_6d

    :cond_19
    new-instance p1, Ljava/lang/IllegalStateException;

    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {p1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw p1

    :cond_21
    iget-object v1, p0, Landroidx/room/d;->d:Lr3/b;

    :try_start_23
    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V
    :try_end_26
    .catchall {:try_start_23 .. :try_end_26} :catchall_17

    goto :goto_45

    :cond_27
    invoke-static {p1}, Ld3/b;->Y1(Ljava/lang/Object;)V

    invoke-virtual {v5}, Landroidx/room/e0;->getInvalidationTracker()Landroidx/room/u;

    move-result-object p1

    invoke-virtual {p1, v4}, Landroidx/room/u;->a(Landroidx/room/s;)V

    :try_start_31
    iget-object p1, p0, Landroidx/room/d;->h:Lr3/j;

    invoke-interface {p1}, Lr3/u;->iterator()Lr3/b;

    move-result-object p1

    :goto_37
    iput-object p1, p0, Landroidx/room/d;->d:Lr3/b;

    iput v3, p0, Landroidx/room/d;->e:I

    invoke-virtual {p1, p0}, Lr3/b;->b(Lz2/e;)Ljava/lang/Object;

    move-result-object v1

    if-ne v1, v0, :cond_42

    return-object v0

    :cond_42
    move-object v7, v1

    move-object v1, p1

    move-object p1, v7

    :goto_45
    check-cast p1, Ljava/lang/Boolean;

    invoke-virtual {p1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result p1

    if-eqz p1, :cond_63

    invoke-virtual {v1}, Lr3/b;->c()Ljava/lang/Object;

    iget-object p1, p0, Landroidx/room/d;->i:Ljava/util/concurrent/Callable;

    invoke-interface {p1}, Ljava/util/concurrent/Callable;->call()Ljava/lang/Object;

    move-result-object p1

    iget-object v6, p0, Landroidx/room/d;->j:Lr3/j;

    iput-object v1, p0, Landroidx/room/d;->d:Lr3/b;

    iput v2, p0, Landroidx/room/d;->e:I

    invoke-interface {v6, p1, p0}, Lr3/v;->c(Ljava/lang/Object;Lz2/e;)Ljava/lang/Object;

    move-result-object p1
    :try_end_60
    .catchall {:try_start_31 .. :try_end_60} :catchall_17

    if-ne p1, v0, :cond_15

    return-object v0

    :cond_63
    invoke-virtual {v5}, Landroidx/room/e0;->getInvalidationTracker()Landroidx/room/u;

    move-result-object p1

    invoke-virtual {p1, v4}, Landroidx/room/u;->c(Landroidx/room/s;)V

    sget-object p1, Lw2/i;->a:Lw2/i;

    return-object p1

    :goto_6d
    invoke-virtual {v5}, Landroidx/room/e0;->getInvalidationTracker()Landroidx/room/u;

    move-result-object v0

    invoke-virtual {v0, v4}, Landroidx/room/u;->c(Landroidx/room/s;)V

    throw p1
.end method

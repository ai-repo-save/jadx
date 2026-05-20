.class public LX/0yTi;
.super Ljava/lang/Object;

.method public static LIZ()Ljava/lang/StringBuilder;
    .locals 1
    new-instance v0, Ljava/lang/StringBuilder;
    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V
    return-object v0
.end method

.method public static LIZIZ(Ljava/lang/StringBuilder;)Ljava/lang/String;
    .locals 1
    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
    move-result-object v0
    return-object v0
.end method

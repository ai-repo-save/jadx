.class public Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;
.super Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMContact;

.field private friendRecTime:J

.method public constructor <init>()V
    .locals 0
    invoke-direct {p0}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMContact;-><init>()V
    return-void
.end method

.method public getFriendRecTime()J
    .locals 2
    iget-wide v0, p0, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->friendRecTime:J
    return-wide v0
.end method

.method public setFriendRecTime(J)V
    .locals 0
    iput-wide p1, p0, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->friendRecTime:J
    return-void
.end method

.method public getFollowStatus()I
    .locals 1
    const/4 v0, 0x0
    return v0
.end method

.method public getShareStatus()I
    .locals 1
    const/4 v0, 0x0
    return v0
.end method

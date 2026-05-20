.class public final LX/0Jyl;
.super LX/0JZr;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "LX/0JZr<",
        "Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMContact;",
        ">;"
    }
.end annotation


# direct methods
.method public static constructor <clinit>()V
    .registers 0

    return-void
.end method

.method public constructor <init>(LX/0TwS;)V
    .registers 2

    .prologue
    .line 16777216
    invoke-direct {p0, p1}, LX/0JZr;-><init>(LX/0TwS;)V

    .line 16777217
    .line 16777218
    .line 16777219
    return-void
.end method


# virtual methods
.method public final LIZ(Ljava/util/List;LX/02xW;)Ljava/lang/Object;
    .registers 21
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMContact;",
            ">;",
            "LX/02xW<",
            "-",
            "Ljava/util/List<",
            "+",
            "Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMContact;",
            ">;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .prologue
    .line 33554432
    move-object/from16 v4, p2

    .line 33554433
    .line 33554434
    move-object/from16 v2, p1

    .line 33554435
    .line 33554436
    instance-of v0, v4, LX/0Jym;

    .line 33554437
    .line 33554438
    if-eqz v0, :cond_1d6

    .line 33554439
    .line 33554440
    move-object v8, v4

    .line 33554441
    check-cast v8, LX/0Jym;

    .line 33554442
    .line 33554443
    iget v3, v8, LX/0Jym;->LLIZ:I

    .line 33554444
    .line 33554445
    const/high16 v1, -0x80000000

    .line 33554446
    .line 33554447
    and-int v0, v3, v1

    .line 33554448
    .line 33554449
    if-eqz v0, :cond_1d6

    .line 33554450
    .line 33554451
    sub-int/2addr v3, v1

    .line 33554452
    iput v3, v8, LX/0Jym;->LLIZ:I

    .line 33554453
    .line 33554454
    :goto_16
    iget-object v1, v8, LX/0Jym;->LLILZIL:Ljava/lang/Object;

    .line 33554455
    .line 33554456
    invoke-static {}, LX/0hdh;->LJFF()Ljava/lang/Object;

    .line 33554457
    .line 33554458
    .line 33554459
    move-result-object v7

    .line 33554460
    iget v0, v8, LX/0Jym;->LLIZ:I

    .line 33554461
    .line 33554462
    const/4 v3, 0x1

    .line 33554463
    const/4 v6, 0x2

    .line 33554464
    const/4 v4, 0x3

    .line 33554465
    const-string v17, ""

    .line 33554466
    .line 33554467
    if-eqz v0, :cond_121

    .line 33554468
    .line 33554469
    if-eq v0, v3, :cond_158

    .line 33554470
    .line 33554471
    if-eq v0, v6, :cond_106

    .line 33554472
    .line 33554473
    if-ne v0, v4, :cond_22a

    .line 33554474
    .line 33554475
    iget-object v10, v8, LX/0Jym;->LLILLJJLI:Ljava/lang/Object;

    .line 33554476
    .line 33554477
    check-cast v10, Ljava/util/Iterator;

    .line 33554478
    .line 33554479
    iget-object v5, v8, LX/0Jym;->LLILLIZIL:Ljava/lang/Object;

    .line 33554480
    .line 33554481
    check-cast v5, Ljava/util/List;

    .line 33554482
    .line 33554483
    iget-object v3, v8, LX/0Jym;->LLILL:Ljava/lang/Object;

    .line 33554484
    .line 33554485
    check-cast v3, Ljava/util/Collection;

    .line 33554486
    .line 33554487
    iget-object v2, v8, LX/0Jym;->LL:Ljava/lang/Object;

    .line 33554488
    .line 33554489
    check-cast v2, Ljava/util/List;

    .line 33554490
    .line 33554491
    invoke-static {v1}, LX/01k1;->LIZIZ(Ljava/lang/Object;)V

    .line 33554492
    .line 33554493
    .line 33554494
    :cond_3e
    :goto_3e
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    .line 33554495
    .line 33554496
    .line 33554497
    move-result v0

    .line 33554498
    if-eqz v0, :cond_1df

    .line 33554499
    .line 33554500
    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 33554501
    .line 33554502
    .line 33554503
    move-result-object v11

    .line 33554504
    check-cast v11, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;

    .line 33554505
    .line 33554506
    invoke-virtual {v11}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getUid()Ljava/lang/String;

    .line 33554507
    .line 33554508
    .line 33554509
    move-result-object v0

    .line 33554510
    if-nez v0, :cond_52

    .line 33554511
    .line 33554512
    move-object/from16 v0, v17

    .line 33554513
    .line 33554514
    :cond_52
    invoke-interface {v5, v0}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 33554515
    .line 33554516
    .line 33554517
    invoke-virtual {v11}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->getFriendRecTime()J

    .line 33554518
    .line 33554519
    .line 33554520
    move-result-wide v14

    .line 33554521
    const-wide/16 v12, 0x0

    .line 33554522
    .line 33554523
    cmp-long v0, v14, v12

    .line 33554524
    .line 33554525
    if-lez v0, :cond_c8

    .line 33554526
    .line 33554527
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    .line 33554528
    .line 33554529
    .line 33554530
    move-result-object v12

    .line 33554531
    :cond_63
    :goto_63
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    .line 33554532
    .line 33554533
    .line 33554534
    move-result v0

    .line 33554535
    if-eqz v0, :cond_3e

    .line 33554536
    .line 33554537
    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 33554538
    .line 33554539
    .line 33554540
    move-result-object v1

    .line 33554541
    check-cast v1, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMContact;

    .line 33554542
    .line 33554543
    invoke-virtual {v11}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getUid()Ljava/lang/String;

    .line 33554544
    .line 33554545
    .line 33554546
    move-result-object v9

    .line 33554547
    check-cast v1, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;

    .line 33554548
    .line 33554549
    invoke-virtual {v1}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getUid()Ljava/lang/String;

    .line 33554550
    .line 33554551
    .line 33554552
    move-result-object v0

    .line 33554553
    invoke-static {v9, v0}, Lkotlin/jvm/internal/Intrinsics;->LJFF(Ljava/lang/Object;Ljava/lang/Object;)Z

    .line 33554554
    .line 33554555
    .line 33554556
    move-result v0

    .line 33554557
    if-eqz v0, :cond_63

    .line 33554558
    .line 33554559
    invoke-virtual {v1}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->getFriendRecTime()J

    .line 33554560
    .line 33554561
    .line 33554562
    move-result-wide v15

    .line 33554563
    invoke-virtual {v11}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->getFriendRecTime()J

    .line 33554564
    .line 33554565
    .line 33554566
    move-result-wide v13

    .line 33554567
    cmp-long v0, v15, v13

    .line 33554568
    .line 33554569
    if-lez v0, :cond_63

    .line 33554570
    .line 33554571
    invoke-virtual {v1}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->getFriendRecTime()J

    .line 33554572
    .line 33554573
    .line 33554574
    move-result-wide v0

    .line 33554575
    invoke-virtual {v11, v0, v1}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->setFriendRecTime(J)V

    .line 33554576
    .line 33554577
    .line 33554578
    sget-object v0, Lcom/ss/android/ugc/aweme/im/contacts/api/IMContactApi;->LIZ:LX/0Jye;

    .line 33554579
    .line 33554580
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 33554581
    .line 33554582
    .line 33554583
    invoke-static {}, LX/0Jye;->LIZ()Lcom/ss/android/ugc/aweme/im/contacts/api/IMContactApi;

    .line 33554584
    .line 33554585
    .line 33554586
    move-result-object v0

    .line 33554587
    invoke-interface {v0}, Lcom/ss/android/ugc/aweme/im/contacts/api/IMContactApi;->LJ()LX/16GD;

    .line 33554588
    .line 33554589
    .line 33554590
    move-result-object v13

    .line 33554591
    iput-object v2, v8, LX/0Jym;->LL:Ljava/lang/Object;

    .line 33554592
    .line 33554593
    iput-object v3, v8, LX/0Jym;->LLILL:Ljava/lang/Object;

    .line 33554594
    .line 33554595
    iput-object v5, v8, LX/0Jym;->LLILLIZIL:Ljava/lang/Object;

    .line 33554596
    .line 33554597
    iput-object v10, v8, LX/0Jym;->LLILLJJLI:Ljava/lang/Object;

    .line 33554598
    .line 33554599
    iput-object v11, v8, LX/0Jym;->LLILLL:Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;

    .line 33554600
    .line 33554601
    iput-object v12, v8, LX/0Jym;->LLILZ:Ljava/lang/Object;

    .line 33554602
    .line 33554603
    iput v6, v8, LX/0Jym;->LLIZ:I

    .line 33554604
    .line 33554605
    invoke-virtual {v11}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getUid()Ljava/lang/String;

    .line 33554606
    .line 33554607
    .line 33554608
    move-result-object v9

    .line 33554609
    invoke-virtual {v11}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getSecUid()Ljava/lang/String;

    .line 33554610
    .line 33554611
    .line 33554612
    move-result-object v1

    .line 33554613
    const-string v0, "im_local_db"

    .line 33554614
    .line 33554615
    invoke-virtual {v13, v9, v1, v0}, LX/16GD;->LJIIZILJ(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;

    .line 33554616
    .line 33554617
    .line 33554618
    move-result-object v9

    .line 33554619
    new-instance v1, LX/02sL;

    .line 33554620
    .line 33554621
    const/4 v0, 0x0

    .line 33554622
    invoke-direct {v1, v0, v4}, LX/02sL;-><init>(ZI)V

    .line 33554623
    .line 33554624
    .line 33554625
    invoke-virtual {v13, v11, v9, v1, v8}, LX/16GD;->LIZJ(Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;LX/02sL;LX/02xW;)Ljava/lang/Object;

    .line 33554626
    .line 33554627
    .line 33554628
    move-result-object v0

    .line 33554629
    if-ne v0, v7, :cond_63

    .line 33554630
    .line 33554631
    return-object v7

    .line 33554632
    :cond_c8
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    .line 33554633
    .line 33554634
    .line 33554635
    move-result-wide v0

    .line 33554636
    invoke-virtual {v11, v0, v1}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->setFriendRecTime(J)V

    .line 33554637
    .line 33554638
    .line 33554639
    sget-object v0, Lcom/ss/android/ugc/aweme/im/contacts/api/IMContactApi;->LIZ:LX/0Jye;

    .line 33554640
    .line 33554641
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 33554642
    .line 33554643
    .line 33554644
    invoke-static {}, LX/0Jye;->LIZ()Lcom/ss/android/ugc/aweme/im/contacts/api/IMContactApi;

    .line 33554645
    .line 33554646
    .line 33554647
    move-result-object v0

    .line 33554648
    invoke-interface {v0}, Lcom/ss/android/ugc/aweme/im/contacts/api/IMContactApi;->LJ()LX/16GD;

    .line 33554649
    .line 33554650
    .line 33554651
    move-result-object v12

    .line 33554652
    iput-object v2, v8, LX/0Jym;->LL:Ljava/lang/Object;

    .line 33554653
    .line 33554654
    iput-object v3, v8, LX/0Jym;->LLILL:Ljava/lang/Object;

    .line 33554655
    .line 33554656
    iput-object v5, v8, LX/0Jym;->LLILLIZIL:Ljava/lang/Object;

    .line 33554657
    .line 33554658
    iput-object v10, v8, LX/0Jym;->LLILLJJLI:Ljava/lang/Object;

    .line 33554659
    .line 33554660
    const/4 v0, 0x0

    .line 33554661
    iput-object v0, v8, LX/0Jym;->LLILLL:Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;

    .line 33554662
    .line 33554663
    iput-object v0, v8, LX/0Jym;->LLILZ:Ljava/lang/Object;

    .line 33554664
    .line 33554665
    iput v4, v8, LX/0Jym;->LLIZ:I

    .line 33554666
    .line 33554667
    invoke-virtual {v11}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getUid()Ljava/lang/String;

    .line 33554668
    .line 33554669
    .line 33554670
    move-result-object v9

    .line 33554671
    invoke-virtual {v11}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getSecUid()Ljava/lang/String;

    .line 33554672
    .line 33554673
    .line 33554674
    move-result-object v1

    .line 33554675
    const-string v0, "im_local_db"

    .line 33554676
    .line 33554677
    invoke-virtual {v12, v9, v1, v0}, LX/16GD;->LJIIZILJ(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;

    .line 33554678
    .line 33554679
    .line 33554680
    move-result-object v9

    .line 33554681
    new-instance v1, LX/02sL;

    .line 33554682
    .line 33554683
    const/4 v0, 0x0

    .line 33554684
    invoke-direct {v1, v0, v4}, LX/02sL;-><init>(ZI)V

    .line 33554685
    .line 33554686
    .line 33554687
    invoke-virtual {v12, v11, v9, v1, v8}, LX/16GD;->LIZJ(Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;LX/02sL;LX/02xW;)Ljava/lang/Object;

    .line 33554688
    .line 33554689
    .line 33554690
    move-result-object v0

    .line 33554691
    if-ne v0, v7, :cond_3e

    .line 33554692
    .line 33554693
    return-object v7

    .line 33554694
    :cond_106
    iget-object v12, v8, LX/0Jym;->LLILZ:Ljava/lang/Object;

    .line 33554695
    .line 33554696
    check-cast v12, Ljava/util/Iterator;

    .line 33554697
    .line 33554698
    iget-object v11, v8, LX/0Jym;->LLILLL:Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;

    .line 33554699
    .line 33554700
    iget-object v10, v8, LX/0Jym;->LLILLJJLI:Ljava/lang/Object;

    .line 33554701
    .line 33554702
    check-cast v10, Ljava/util/Iterator;

    .line 33554703
    .line 33554704
    iget-object v5, v8, LX/0Jym;->LLILLIZIL:Ljava/lang/Object;

    .line 33554705
    .line 33554706
    check-cast v5, Ljava/util/List;

    .line 33554707
    .line 33554708
    iget-object v3, v8, LX/0Jym;->LLILL:Ljava/lang/Object;

    .line 33554709
    .line 33554710
    check-cast v3, Ljava/util/Collection;

    .line 33554711
    .line 33554712
    iget-object v2, v8, LX/0Jym;->LL:Ljava/lang/Object;

    .line 33554713
    .line 33554714
    check-cast v2, Ljava/util/List;

    .line 33554715
    .line 33554716
    invoke-static {v1}, LX/01k1;->LIZIZ(Ljava/lang/Object;)V

    .line 33554717
    .line 33554718
    .line 33554719
    goto/16 :goto_63

    .line 33554720
    .line 33554721
    :cond_121
    invoke-static {v1}, LX/01k1;->LIZIZ(Ljava/lang/Object;)V

    .line 33554722
    .line 33554723
    .line 33554724
    invoke-static {}, LX/0yTi;->LIZ()Ljava/lang/StringBuilder;

    .line 33554725
    .line 33554726
    .line 33554727
    move-result-object v1

    .line 33554728
    const-string v0, "sort start "

    .line 33554729
    .line 33554730
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 33554731
    .line 33554732
    .line 33554733
    invoke-interface {v2}, Ljava/util/List;->size()I

    .line 33554734
    .line 33554735
    .line 33554736
    move-result v0

    .line 33554737
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 33554738
    .line 33554739
    .line 33554740
    invoke-static {v1}, LX/0yTi;->LIZIZ(Ljava/lang/StringBuilder;)Ljava/lang/String;

    .line 33554741
    .line 33554742
    .line 33554743
    invoke-static {}, LX/0TyN;->LIZLLL()LX/16Hu;

    .line 33554744
    .line 33554745
    .line 33554746
    move-result-object v1

    .line 33554747
    invoke-static {}, LX/0SnS;->LIZLLL()Lcom/ss/android/ugc/aweme/profile/model/User;

    .line 33554748
    .line 33554749
    .line 33554750
    move-result-object v0

    .line 33554751
    if-eqz v0, :cond_147

    .line 33554752
    .line 33554753
    invoke-virtual {v0}, Lcom/ss/android/ugc/aweme/profile/model/User;->getUid()Ljava/lang/String;

    .line 33554754
    .line 33554755
    .line 33554756
    move-result-object v0

    .line 33554757
    if-nez v0, :cond_149

    .line 33554758
    .line 33554759
    :cond_147
    move-object/from16 v0, v17

    .line 33554760
    .line 33554761
    :cond_149
    invoke-static {v0}, Ljava/util/Collections;->singletonList(Ljava/lang/Object;)Ljava/util/List;

    .line 33554762
    .line 33554763
    .line 33554764
    move-result-object v0

    .line 33554765
    iput-object v2, v8, LX/0Jym;->LL:Ljava/lang/Object;

    .line 33554766
    .line 33554767
    iput v3, v8, LX/0Jym;->LLIZ:I

    .line 33554768
    .line 33554769
    invoke-virtual {v1, v3, v0, v8}, LX/16Hu;->LJI(ILjava/util/List;LX/02xW;)Ljava/lang/Object;

    .line 33554770
    .line 33554771
    .line 33554772
    move-result-object v1

    .line 33554773
    if-ne v1, v7, :cond_15f

    .line 33554774
    .line 33554775
    return-object v7

    .line 33554776
    :cond_158
    iget-object v2, v8, LX/0Jym;->LL:Ljava/lang/Object;

    .line 33554777
    .line 33554778
    check-cast v2, Ljava/util/List;

    .line 33554779
    .line 33554780
    invoke-static {v1}, LX/01k1;->LIZIZ(Ljava/lang/Object;)V

    .line 33554781
    .line 33554782
    .line 33554783
    :cond_15f
    check-cast v1, Ljava/lang/Iterable;

    .line 33554784
    .line 33554785
    new-instance v3, Ljava/util/ArrayList;

    .line 33554786
    .line 33554787
    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 33554788
    .line 33554789
    .line 33554790
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    .line 33554791
    .line 33554792
    .line 33554793
    move-result-object v12

    .line 33554794
    :cond_16a
    :goto_16a
    invoke-interface {v12}, Ljava/util/Iterator;->hasNext()Z

    .line 33554795
    .line 33554796
    .line 33554797
    move-result v0

    .line 33554798
    if-eqz v0, :cond_1b1

    .line 33554799
    .line 33554800
    invoke-interface {v12}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 33554801
    .line 33554802
    .line 33554803
    move-result-object v10

    .line 33554804
    move-object v1, v10

    .line 33554805
    check-cast v1, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;

    .line 33554806
    .line 33554807
    invoke-virtual {v1}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->getFollowStatus()I

    .line 33554808
    .line 33554809
    .line 33554810
    move-result v0

    .line 33554811
    const/4 v11, 0x0

    .line 33554812
    if-eqz v0, :cond_16a

    .line 33554813
    .line 33554814
    invoke-virtual {v1}, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMUser;->getShareStatus()I

    .line 33554815
    .line 33554816
    .line 33554817
    move-result v0

    .line 33554818
    if-eq v0, v6, :cond_16a

    .line 33554819
    .line 33554820
    invoke-static {}, LX/0tKv;->LIZ()LX/0tKv;

    .line 33554821
    .line 33554822
    .line 33554823
    move-result-object v9

    .line 33554824
    invoke-virtual {v1}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getUid()Ljava/lang/String;

    .line 33554825
    .line 33554826
    .line 33554827
    move-result-object v5

    .line 33554828
    invoke-virtual {v9}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 33554829
    .line 33554830
    .line 33554831
    invoke-static {v5}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    .line 33554832
    .line 33554833
    .line 33554834
    move-result v0

    .line 33554835
    if-nez v0, :cond_1ad

    .line 33554836
    .line 33554837
    invoke-static {}, LX/0yTi;->LIZ()Ljava/lang/StringBuilder;

    .line 33554838
    .line 33554839
    .line 33554840
    move-result-object v1

    .line 33554841
    const-string v0, "key_friend_rec_"

    .line 33554842
    .line 33554843
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 33554844
    .line 33554845
    .line 33554846
    invoke-virtual {v1, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 33554847
    .line 33554848
    .line 33554849
    invoke-static {v1}, LX/0yTi;->LIZIZ(Ljava/lang/StringBuilder;)Ljava/lang/String;

    .line 33554850
    .line 33554851
    .line 33554852
    move-result-object v1

    .line 33554853
    iget-object v0, v9, LX/0tKv;->LIZ:Landroid/content/SharedPreferences;

    .line 33554854
    .line 33554855
    invoke-interface {v0, v1, v11}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    .line 33554856
    .line 33554857
    .line 33554858
    move-result v0

    .line 33554859
    if-nez v0, :cond_16a

    .line 33554860
    .line 33554861
    :cond_1ad
    invoke-virtual {v3, v10}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 33554862
    .line 33554863
    .line 33554864
    goto :goto_16a

    .line 33554865
    :cond_1b1
    invoke-static {}, LX/0yTi;->LIZ()Ljava/lang/StringBuilder;

    .line 33554866
    .line 33554867
    .line 33554868
    move-result-object v1

    .line 33554869
    const-string v0, "query db finish "

    .line 33554870
    .line 33554871
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 33554872
    .line 33554873
    .line 33554874
    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    .line 33554875
    .line 33554876
    .line 33554877
    move-result v0

    .line 33554878
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 33554879
    .line 33554880
    .line 33554881
    invoke-static {v1}, LX/0yTi;->LIZIZ(Ljava/lang/StringBuilder;)Ljava/lang/String;

    .line 33554882
    .line 33554883
    .line 33554884
    invoke-virtual {v3}, Ljava/util/ArrayList;->isEmpty()Z

    .line 33554885
    .line 33554886
    .line 33554887
    move-result v0

    .line 33554888
    if-eqz v0, :cond_1cb

    .line 33554889
    .line 33554890
    return-object v2

    .line 33554891
    :cond_1cb
    new-instance v5, Ljava/util/ArrayList;

    .line 33554892
    .line 33554893
    invoke-direct {v5}, Ljava/util/ArrayList;-><init>()V

    .line 33554894
    .line 33554895
    .line 33554896
    invoke-virtual {v3}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    .line 33554897
    .line 33554898
    .line 33554899
    move-result-object v10

    .line 33554900
    goto/16 :goto_3e

    .line 33554901
    .line 33554902
    :cond_1d6
    new-instance v8, LX/0Jym;

    .line 33554903
    .line 33554904
    move-object/from16 v0, p0

    .line 33554905
    .line 33554906
    invoke-direct {v8, v0, v4}, LX/0Jym;-><init>(LX/0Jyl;LX/02xW;)V

    .line 33554907
    .line 33554908
    .line 33554909
    goto/16 :goto_16

    .line 33554910
    .line 33554911
    :cond_1df
    new-instance v4, Ljava/util/ArrayList;

    .line 33554912
    .line 33554913
    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 33554914
    .line 33554915
    .line 33554916
    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 33554917
    .line 33554918
    .line 33554919
    new-instance v3, Ljava/util/ArrayList;

    .line 33554920
    .line 33554921
    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    .line 33554922
    .line 33554923
    .line 33554924
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    .line 33554925
    .line 33554926
    .line 33554927
    move-result-object v2

    .line 33554928
    :cond_1f0
    :goto_1f0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    .line 33554929
    .line 33554930
    .line 33554931
    move-result v0

    .line 33554932
    if-eqz v0, :cond_20d

    .line 33554933
    .line 33554934
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    .line 33554935
    .line 33554936
    .line 33554937
    move-result-object v1

    .line 33554938
    move-object v0, v1

    .line 33554939
    check-cast v0, Lcom/ss/android/ugc/aweme/im/contacts/api/model/IMContact;

    .line 33554940
    .line 33554941
    invoke-virtual {v0}, Lcom/ss/android/ugc/aweme/im/common/model/BaseContact;->getUid()Ljava/lang/String;

    .line 33554942
    .line 33554943
    .line 33554944
    move-result-object v0

    .line 33554945
    invoke-static {v5, v0}, LX/0yOP;->LJJJIL(Ljava/lang/Iterable;Ljava/lang/Object;)Z

    .line 33554946
    .line 33554947
    .line 33554948
    move-result v0

    .line 33554949
    xor-int/lit8 v0, v0, 0x1

    .line 33554950
    .line 33554951
    if-eqz v0, :cond_1f0

    .line 33554952
    .line 33554953
    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 33554954
    .line 33554955
    .line 33554956
    goto :goto_1f0

    .line 33554957
    :cond_20d
    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 33554958
    .line 33554959
    .line 33554960
    sget-object v0, LX/0JZy;->LL:LX/0JZy;

    .line 33554961
    .line 33554962
    invoke-static {v0, v4}, LX/0yOP;->LJLJLJ(Ljava/util/Comparator;Ljava/lang/Iterable;)Ljava/util/List;

    .line 33554963
    .line 33554964
    .line 33554965
    move-result-object v2

    .line 33554966
    invoke-static {}, LX/0yTi;->LIZ()Ljava/lang/StringBuilder;

    .line 33554967
    .line 33554968
    .line 33554969
    move-result-object v1

    .line 33554970
    const-string v0, "finish sorting "

    .line 33554971
    .line 33554972
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 33554973
    .line 33554974
    .line 33554975
    invoke-virtual {v4}, Ljava/util/ArrayList;->size()I

    .line 33554976
    .line 33554977
    .line 33554978
    move-result v0

    .line 33554979
    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 33554980
    .line 33554981
    .line 33554982
    invoke-static {v1}, LX/0yTi;->LIZIZ(Ljava/lang/StringBuilder;)Ljava/lang/String;

    .line 33554983
    .line 33554984
    .line 33554985
    return-object v2

    .line 33554986
    :cond_22a
    new-instance v1, Ljava/lang/IllegalStateException;

    .line 33554987
    .line 33554988
    const-string v0, "call to \'resume\' before \'invoke\' with coroutine"

    .line 33554989
    .line 33554990
    invoke-direct {v1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .line 33554991
    .line 33554992
    .line 33554993
    throw v1
.end method

###### Class X.C494320JZy (X.0JZy)

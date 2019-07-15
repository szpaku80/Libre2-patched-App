.class public Lcom/librelink/app/ForegroundService;
.super Landroid/app/Service;
.source "ForegroundService.java"


# static fields
.field public static final CHANNEL_ID:Ljava/lang/String; = "FOREGROUND_SERVICE"

.field public static final CHANNEL_NAME:Ljava/lang/String; = "Foreground Service Notification"

.field public static final DESCRIPTION:Ljava/lang/String; = "Prevents LibreLink from being stopped, you may hide this."

.field public static final IMPORTANCE:I = 0x2

.field public static final NOTIFICATION_ID:I = 0x2a


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 12
    invoke-direct {p0}, Landroid/app/Service;-><init>()V

    return-void
.end method

.method public static createNotificationChannel(Landroid/content/Context;)V
    .registers 5
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 57
    new-instance v0, Landroid/app/NotificationChannel;

    const-string v1, "FOREGROUND_SERVICE"

    const-string v2, "Foreground Service Notification"

    const/4 v3, 0x2

    invoke-direct {v0, v1, v2, v3}, Landroid/app/NotificationChannel;-><init>(Ljava/lang/String;Ljava/lang/CharSequence;I)V

    .line 58
    .local v0, "notificationChannel":Landroid/app/NotificationChannel;
    const-string v1, "Prevents LibreLink from being stopped, you may hide this."

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setDescription(Ljava/lang/String;)V

    .line 59
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/NotificationChannel;->setShowBadge(Z)V

    .line 60
    const-class v1, Landroid/app/NotificationManager;

    invoke-virtual {p0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    invoke-virtual {v1, v0}, Landroid/app/NotificationManager;->createNotificationChannel(Landroid/app/NotificationChannel;)V

    .line 61
    return-void
.end method

.method public static initialize(Landroid/content/Context;)V
    .registers 3
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 50
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_13

    .line 51
    invoke-static {p0}, Lcom/librelink/app/ForegroundService;->createNotificationChannel(Landroid/content/Context;)V

    .line 52
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/librelink/app/ForegroundService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Landroid/content/Context;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    .line 54
    :cond_13
    return-void
.end method


# virtual methods
.method public onBind(Landroid/content/Intent;)Landroid/os/IBinder;
    .registers 3
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 22
    const/4 v0, 0x0

    return-object v0
.end method

.method public onCreate()V
    .registers 5

    .prologue
    const/16 v3, 0x2a

    .line 27
    invoke-super {p0}, Landroid/app/Service;->onCreate()V

    .line 28
    new-instance v1, Landroid/app/Notification$Builder;

    const-string v2, "FOREGROUND_SERVICE"

    invoke-direct {v1, p0, v2}, Landroid/app/Notification$Builder;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    const v2, 0x7f0800f1

    .line 29
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setSmallIcon(I)Landroid/app/Notification$Builder;

    move-result-object v1

    const-string v2, "Foreground Service Notification"

    .line 30
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentTitle(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    const-string v2, "Prevents LibreLink from being stopped, you may hide this."

    .line 31
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setContentText(Ljava/lang/CharSequence;)Landroid/app/Notification$Builder;

    move-result-object v1

    const/4 v2, 0x1

    .line 32
    invoke-virtual {v1, v2}, Landroid/app/Notification$Builder;->setOngoing(Z)Landroid/app/Notification$Builder;

    move-result-object v1

    .line 33
    invoke-virtual {v1}, Landroid/app/Notification$Builder;->build()Landroid/app/Notification;

    move-result-object v0

    .line 34
    .local v0, "notification":Landroid/app/Notification;
    const-class v1, Landroid/app/NotificationManager;

    invoke-virtual {p0, v1}, Lcom/librelink/app/ForegroundService;->getSystemService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/NotificationManager;

    invoke-virtual {v1, v3, v0}, Landroid/app/NotificationManager;->notify(ILandroid/app/Notification;)V

    .line 35
    invoke-virtual {p0, v3, v0}, Lcom/librelink/app/ForegroundService;->startForeground(ILandroid/app/Notification;)V

    .line 36
    return-void
.end method

.method public onDestroy()V
    .registers 2

    .prologue
    .line 45
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/librelink/app/ForegroundService;->stopForeground(Z)V

    .line 46
    invoke-super {p0}, Landroid/app/Service;->onDestroy()V

    .line 47
    return-void
.end method

.method public onStartCommand(Landroid/content/Intent;II)I
    .registers 5
    .param p1, "intent"    # Landroid/content/Intent;
    .param p2, "flags"    # I
    .param p3, "startId"    # I

    .prologue
    .line 40
    const/4 v0, 0x1

    return v0
.end method

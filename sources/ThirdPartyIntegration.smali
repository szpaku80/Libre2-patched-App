.class public Lcom/librelink/app/ThirdPartyIntegration;
.super Ljava/lang/Object;
.source "ThirdPartyIntegration.java"


# static fields
.field private static context:Landroid/content/Context;


# direct methods
.method public constructor <init>()V
    .registers 1

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static sendIntent(Landroid/content/Intent;)V
    .registers 2
    .param p0, "intent"    # Landroid/content/Intent;

    .prologue
    .line 25
    const-string v0, "com.eveningoutpost.dexdrip"

    invoke-virtual {p0, v0}, Landroid/content/Intent;->setPackage(Ljava/lang/String;)Landroid/content/Intent;

    .line 26
    sget-object v0, Lcom/librelink/app/ThirdPartyIntegration;->context:Landroid/content/Context;

    invoke-virtual {v0, p0}, Landroid/content/Context;->sendBroadcast(Landroid/content/Intent;)V
	
    .line 35
    return-void
.end method

.method private static getBLEManagerFields(Lcom/librelink/app/core/BleManager;)Landroid/os/Bundle;
    .registers 4
    .param p0, "bleManager"    # Lcom/librelink/app/core/BleManager;

    .prologue
    .line 92
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 93
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v1, "sensorSerial"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSensorSerial()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 94
    const-string v1, "sensorAddress"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSensorAddress()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 95
    return-object v0
.end method

.method private static getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;
    .registers 9
    .param p0, "sas"    # Lcom/librelink/app/types/SAS;

    .prologue
    const v7, 0x7fffffff

    const/4 v6, 0x1

    .line 77
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 78
    .local v0, "bundle":Landroid/os/Bundle;
    invoke-interface {p0}, Lcom/librelink/app/types/SAS;->getCurrentlySelectedSensor()Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;

    move-result-object v1

    .line 79
    .local v1, "sensor":Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;, "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor<Lorg/joda/time/DateTime;>;"
    if-eqz v1, :cond_21

    .line 80
    const-string v2, "currentSensor"

    invoke-static {v1}, Lcom/librelink/app/ThirdPartyIntegration;->getSensorFields(Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;)Landroid/os/Bundle;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 81
    const-string v2, "sensorStatusCode"

    invoke-interface {p0, v1}, Lcom/librelink/app/types/SAS;->getSensorStatusCode(Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 83
    :cond_21
    const-string v2, "version"

    invoke-interface {p0}, Lcom/librelink/app/types/SAS;->getVersion()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 84
    const-string v2, "realTimeGlucoseReadings"

    sget-object v3, Lorg/joda/time/DateTimeZone;->UTC:Lorg/joda/time/DateTimeZone;

    invoke-static {v3}, Lorg/joda/time/DateTime;->now(Lorg/joda/time/DateTimeZone;)Lorg/joda/time/DateTime;

    move-result-object v3

    invoke-virtual {v3, v6}, Lorg/joda/time/DateTime;->minusDays(I)Lorg/joda/time/DateTime;

    move-result-object v3

    sget-object v4, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/TimestampType;->UTC:Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/TimestampType;

    sget-object v5, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/ResultFilter;->ALL:Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/ResultFilter;

    invoke-interface {p0, v3, v4, v7, v5}, Lcom/librelink/app/types/SAS;->getRealTimeGlucoseReadingsAfter(Lorg/joda/time/DateTime;Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/TimestampType;ILcom/abbottdiabetescare/flashglucose/sensorabstractionservice/ResultFilter;)Ljava/util/List;

    move-result-object v3

    invoke-static {v3}, Lcom/librelink/app/ThirdPartyIntegration;->packRealTimeGlucoseReadings(Ljava/util/List;)Landroid/os/Bundle;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 86
    const-string v2, "historicGlucoseReadings"

    sget-object v3, Lorg/joda/time/DateTimeZone;->UTC:Lorg/joda/time/DateTimeZone;

    invoke-static {v3}, Lorg/joda/time/DateTime;->now(Lorg/joda/time/DateTimeZone;)Lorg/joda/time/DateTime;

    move-result-object v3

    invoke-virtual {v3, v6}, Lorg/joda/time/DateTime;->minusDays(I)Lorg/joda/time/DateTime;

    move-result-object v3

    sget-object v4, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/TimestampType;->UTC:Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/TimestampType;

    sget-object v5, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/ResultFilter;->ALL:Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/ResultFilter;

    invoke-interface {p0, v3, v4, v7, v5}, Lcom/librelink/app/types/SAS;->getHistoricGlucoseReadingsAfter(Lorg/joda/time/DateTime;Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/TimestampType;ILcom/abbottdiabetescare/flashglucose/sensorabstractionservice/ResultFilter;)Ljava/util/List;

    move-result-object v3

    invoke-static {v3}, Lcom/librelink/app/ThirdPartyIntegration;->packHistoricGlucoseReadings(Ljava/util/List;)Landroid/os/Bundle;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 88
    return-object v0
.end method

.method private static getSensorFields(Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;)Landroid/os/Bundle;
    .registers 5
    .param p0, "sensor"    # Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;

    .prologue
    .line 38
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 39
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v1, "recordNumber"

    invoke-virtual {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;->getRecordNumber()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 40
    const-string v1, "serialNumber"

    invoke-virtual {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;->getSerialNumber()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 41
    const-string v1, "sensorStartTime"

    invoke-virtual {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;->getSensorStartTime()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 42
    const-string v1, "streamingAvailable"

    invoke-virtual {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;->getStreamingAvailable()Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 43
    const-string v1, "warmUpEndTime"

    invoke-virtual {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;->getWarmupEndTime()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 44
    const-string v1, "expireTime"

    invoke-virtual {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;->getExpireTime()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 45
    const-string v1, "endedEarly"

    invoke-virtual {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;->getEndedEarly()Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 46
    return-object v0
.end method

.method private static getSensorGlucoseFields(Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;)Landroid/os/Bundle;
    .registers 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose",
            "<",
            "Lorg/joda/time/DateTime;",
            ">;)",
            "Landroid/os/Bundle;"
        }
    .end annotation

    .prologue
    .line 50
    .local p0, "sensorGlucose":Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;, "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose<Lorg/joda/time/DateTime;>;"
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 51
    .local v0, "bundle":Landroid/os/Bundle;
    const-string v1, "glucoseValue"

    invoke-interface {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;->getGlucoseValue()D

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->putDouble(Ljava/lang/String;D)V

    .line 52
    const-string v1, "millisSincePrevious"

    invoke-interface {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;->getMillisecondsTimeChangeSincePrevious()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 53
    const-string v1, "recordNumber"

    invoke-interface {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;->getRecordNumber()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 54
    const-string v1, "sensorSerial"

    invoke-interface {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;->getSensor()Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;

    move-result-object v2

    invoke-virtual {v2}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;->getSerialNumber()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 55
    const-string v2, "timestamp"

    invoke-interface {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;->getTimestampUTC()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/joda/time/DateTime;

    invoke-virtual {v1}, Lorg/joda/time/DateTime;->toDate()Ljava/util/Date;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    invoke-virtual {v0, v2, v4, v5}, Landroid/os/Bundle;->putLong(Ljava/lang/String;J)V

    .line 56
    const-string v1, "fromSelectedSensor"

    invoke-interface {p0}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;->isFromSelectedSensor()Z

    move-result v2

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->putBoolean(Ljava/lang/String;Z)V

    .line 57
    return-object v0
.end method

.method public static injectContext(Landroid/content/Context;)V
    .registers 1
    .param p0, "context"    # Landroid/content/Context;

    .prologue
    .line 21
    sput-object p0, Lcom/librelink/app/ThirdPartyIntegration;->context:Landroid/content/Context;

    .line 22
    return-void
.end method

.method private static packHistoricGlucoseReadings(Ljava/util/List;)Landroid/os/Bundle;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/HistoricGlucose",
            "<",
            "Lorg/joda/time/DateTime;",
            ">;>;)",
            "Landroid/os/Bundle;"
        }
    .end annotation

    .prologue
    .line 61
    .local p0, "readings":Ljava/util/List;, "Ljava/util/List<Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/HistoricGlucose<Lorg/joda/time/DateTime;>;>;"
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 62
    .local v0, "bundle":Landroid/os/Bundle;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_6
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_20

    .line 63
    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSensorGlucoseFields(Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v3, v2}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 62
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 65
    :cond_20
    return-object v0
.end method

.method private static packRealTimeGlucoseReadings(Ljava/util/List;)Landroid/os/Bundle;
    .registers 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List",
            "<",
            "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/RealTimeGlucose",
            "<",
            "Lorg/joda/time/DateTime;",
            ">;>;)",
            "Landroid/os/Bundle;"
        }
    .end annotation

    .prologue
    .line 69
    .local p0, "readings":Ljava/util/List;, "Ljava/util/List<Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/RealTimeGlucose<Lorg/joda/time/DateTime;>;>;"
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    .line 70
    .local v0, "bundle":Landroid/os/Bundle;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_6
    invoke-interface {p0}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_20

    .line 71
    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v3

    invoke-interface {p0, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSensorGlucoseFields(Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/SensorGlucose;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v3, v2}, Landroid/os/Bundle;->putBundle(Ljava/lang/String;Landroid/os/Bundle;)V

    .line 70
    add-int/lit8 v1, v1, 0x1

    goto :goto_6

    .line 73
    :cond_20
    return-object v0
.end method

.method public static sendCharacteristicValueBroadcast(Lcom/librelink/app/core/BleManager;[B)V
    .registers 5
    .param p0, "bleManager"    # Lcom/librelink/app/core/BleManager;
    .param p1, "bytes"    # [B

    .prologue
    .line 175
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.CHARACTERISTIC_VALUE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 176
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "bytes"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;[B)Landroid/content/Intent;

    .line 177
    const-string v1, "bleManager"

    invoke-static {p0}, Lcom/librelink/app/ThirdPartyIntegration;->getBLEManagerFields(Lcom/librelink/app/core/BleManager;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 178
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 179
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 180
    return-void
.end method

.method public static sendConnectionStateBroadcast(Lcom/librelink/app/core/BleManager;I)V
    .registers 6
    .param p0, "bleManager"    # Lcom/librelink/app/core/BleManager;
    .param p1, "connectionState"    # I

    .prologue
    .line 115
    new-instance v0, Landroid/content/Intent;

    const-string v2, "com.librelink.app.ThirdPartyIntegration.CONNECTION_STATE"

    invoke-direct {v0, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 116
    .local v0, "intent":Landroid/content/Intent;
    const/4 v1, 0x0

    .line 117
    .local v1, "state":Ljava/lang/String;
    packed-switch p1, :pswitch_data_36

    .line 131
    :goto_b
    const-string v2, "connectionState"

    invoke-virtual {v0, v2, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 132
    const-string v2, "bleManager"

    invoke-static {p0}, Lcom/librelink/app/ThirdPartyIntegration;->getBLEManagerFields(Lcom/librelink/app/core/BleManager;)Landroid/os/Bundle;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 133
    const-string v2, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v3

    invoke-static {v3}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 134
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 135
    return-void

    .line 119
    :pswitch_2a
    const-string v1, "DISCONNECTED"

    .line 120
    goto :goto_b

    .line 122
    :pswitch_2d
    const-string v1, "DISCONNECTING"

    .line 123
    goto :goto_b

    .line 125
    :pswitch_30
    const-string v1, "CONNECTING"

    .line 126
    goto :goto_b

    .line 128
    :pswitch_33
    const-string v1, "CONNECTED"

    goto :goto_b

    .line 117
    :pswitch_data_36
    .packed-switch 0x0
        :pswitch_2a
        :pswitch_30
        :pswitch_33
        :pswitch_2d
    .end packed-switch
.end method

.method public static sendFoundDeviceBroadcast(Lcom/librelink/app/core/BleManager;)V
    .registers 4
    .param p0, "bleManager"    # Lcom/librelink/app/core/BleManager;

    .prologue
    .line 108
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.FOUND_DEVICE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 109
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "bleManager"

    invoke-static {p0}, Lcom/librelink/app/ThirdPartyIntegration;->getBLEManagerFields(Lcom/librelink/app/core/BleManager;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 110
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 111
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 112
    return-void
.end method

.method public static sendGlucoseBroadcast(Lcom/librelink/app/core/BleManager;Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/CurrentGlucose;)V
    .registers 8
    .param p0, "bleManager"    # Lcom/librelink/app/core/BleManager;
    .param p1, "currentGlucose"    # Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/CurrentGlucose;

    .prologue
    .line 99
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.GLUCOSE_READING"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 100
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "glucose"

    invoke-virtual {p1}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/CurrentGlucose;->getGlucoseValue()D

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;D)Landroid/content/Intent;

    .line 101
    const-string v2, "timestamp"

    invoke-virtual {p1}, Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/CurrentGlucose;->getTimestampUTC()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lorg/joda/time/DateTime;

    invoke-virtual {v1}, Lorg/joda/time/DateTime;->toDate()Ljava/util/Date;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v4

    invoke-virtual {v0, v2, v4, v5}, Landroid/content/Intent;->putExtra(Ljava/lang/String;J)Landroid/content/Intent;

    .line 102
    const-string v1, "bleManager"

    invoke-static {p0}, Lcom/librelink/app/ThirdPartyIntegration;->getBLEManagerFields(Lcom/librelink/app/core/BleManager;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 103
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 104
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 105
    return-void
.end method

.method public static sendInitializeBluetoothBroadcast(Lcom/librelink/app/core/BleManager;)V
    .registers 4
    .param p0, "bleManager"    # Lcom/librelink/app/core/BleManager;

    .prologue
    .line 168
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.INITIALIZE_BLUETOOTH"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 169
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "bleManager"

    invoke-static {p0}, Lcom/librelink/app/ThirdPartyIntegration;->getBLEManagerFields(Lcom/librelink/app/core/BleManager;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 170
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 171
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 172
    return-void
.end method

.method public static sendRSSIBroadcast(Lcom/librelink/app/core/BleManager;I)V
    .registers 5
    .param p0, "bleManager"    # Lcom/librelink/app/core/BleManager;
    .param p1, "rssi"    # I

    .prologue
    .line 138
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.RSSI"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 139
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "rssi"

    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    .line 140
    const-string v1, "bleManager"

    invoke-static {p0}, Lcom/librelink/app/ThirdPartyIntegration;->getBLEManagerFields(Lcom/librelink/app/core/BleManager;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 141
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 142
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 143
    return-void
.end method

.method public static sendSensorActivateBroadcast(Lcom/librelink/app/ui/common/ScanSensorFragment;Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;)V
    .registers 5
    .param p0, "fragment"    # Lcom/librelink/app/ui/common/ScanSensorFragment;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/librelink/app/ui/common/ScanSensorFragment;",
            "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor",
            "<",
            "Lorg/joda/time/DateTime;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 190
    .local p1, "sensor":Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;, "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor<Lorg/joda/time/DateTime;>;"
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.SENSOR_ACTIVATE"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 191
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "sensor"

    invoke-static {p1}, Lcom/librelink/app/ThirdPartyIntegration;->getSensorFields(Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 192
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/ui/common/ScanSensorFragment;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 193
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 194
    return-void
.end method

.method public static sendSensorBLEExceptionBroadcast(Lcom/librelink/app/core/BleManager;Ljava/lang/Throwable;)V
    .registers 5
    .param p0, "bleManager"    # Lcom/librelink/app/core/BleManager;
    .param p1, "exception"    # Ljava/lang/Throwable;

    .prologue
    .line 146
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.SENSOR_BLE_EXCEPTION"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 147
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "exceptionType"

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 148
    const-string v1, "bleManager"

    invoke-static {p0}, Lcom/librelink/app/ThirdPartyIntegration;->getBLEManagerFields(Lcom/librelink/app/core/BleManager;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 149
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/core/BleManager;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 150
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 151
    return-void
.end method

.method public static sendSensorNFCActivateExceptionBroadcast(Lcom/librelink/app/ui/common/ScanSensorFragment;Ljava/lang/Throwable;)V
    .registers 5
    .param p0, "fragment"    # Lcom/librelink/app/ui/common/ScanSensorFragment;
    .param p1, "exception"    # Ljava/lang/Throwable;

    .prologue
    .line 161
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.SENSOR_NFC_ACTIVATE_EXCEPTION"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 162
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "exceptionType"

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 163
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/ui/common/ScanSensorFragment;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 164
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 165
    return-void
.end method

.method public static sendSensorNFCScanExceptionBroadcast(Lcom/librelink/app/ui/common/ScanSensorFragment;Ljava/lang/Throwable;)V
    .registers 5
    .param p0, "fragment"    # Lcom/librelink/app/ui/common/ScanSensorFragment;
    .param p1, "exception"    # Ljava/lang/Throwable;

    .prologue
    .line 154
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.SENSOR_NFC_SCAN_EXCEPTION"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 155
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "exceptionType"

    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getCanonicalName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 156
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/ui/common/ScanSensorFragment;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 157
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 158
    return-void
.end method

.method public static sendSensorScanBroadcast(Lcom/librelink/app/ui/common/ScanSensorFragment;Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;)V
    .registers 5
    .param p0, "fragment"    # Lcom/librelink/app/ui/common/ScanSensorFragment;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/librelink/app/ui/common/ScanSensorFragment;",
            "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor",
            "<",
            "Lorg/joda/time/DateTime;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 183
    .local p1, "sensor":Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;, "Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor<Lorg/joda/time/DateTime;>;"
    new-instance v0, Landroid/content/Intent;

    const-string v1, "com.librelink.app.ThirdPartyIntegration.SENSOR_SCAN"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 184
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "sensor"

    invoke-static {p1}, Lcom/librelink/app/ThirdPartyIntegration;->getSensorFields(Lcom/abbottdiabetescare/flashglucose/sensorabstractionservice/Sensor;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 185
    const-string v1, "sas"

    invoke-virtual {p0}, Lcom/librelink/app/ui/common/ScanSensorFragment;->getSAS()Lcom/librelink/app/types/SAS;

    move-result-object v2

    invoke-static {v2}, Lcom/librelink/app/ThirdPartyIntegration;->getSASFields(Lcom/librelink/app/types/SAS;)Landroid/os/Bundle;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Landroid/os/Bundle;)Landroid/content/Intent;

    .line 186
    invoke-static {v0}, Lcom/librelink/app/ThirdPartyIntegration;->sendIntent(Landroid/content/Intent;)V

    .line 187
    return-void
.end method

package com.wondersgroup.operation.util.file;

import java.io.Serializable;

/**
 * 文件上传进度
 *
 * @author wanglei
 */
public class FileUploadProgress implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = -8611320884089065215L;

    private long num100Ks = 0;
    private long bytesRead = 0; //已读取长度
    private long contentLength = -1; //总长度
    private int whichItem = 0; //第几个文件
    private double percentDone = 0.00; //进度百分比
    private boolean contentLengthKnown = false;

    public void rest() {
        num100Ks = 0;
        bytesRead = 0;
        contentLength = -1;
        whichItem = 0;
        percentDone = 0.00;
        contentLengthKnown = false;
    }

    public void update(long bytesRead, long contentLength, int items) {
        if (contentLength > -1) {
            contentLengthKnown = true;
        }
        this.bytesRead = bytesRead;
        this.contentLength = contentLength;
        whichItem = items;

        long nowNum100Ks = bytesRead / 100000;
        if (nowNum100Ks > num100Ks) {
            num100Ks = nowNum100Ks;
            if (contentLengthKnown) {
                //percentDone = BigDecimal.valueOf(100.0 * bytesRead / contentLength).setScale(0, RoundingMode.HALF_UP).doubleValue();
                percentDone = Math.round(100.0 * bytesRead / contentLength);
            }
        }
    }

    public long getNum100Ks() {
        return num100Ks;
    }

    public long getBytesRead() {
        return bytesRead;
    }

    public long getContentLength() {
        return contentLength;
    }

    public int getWhichItem() {
        return whichItem;
    }

    public double getPercentDone() {
        return percentDone;
    }
}

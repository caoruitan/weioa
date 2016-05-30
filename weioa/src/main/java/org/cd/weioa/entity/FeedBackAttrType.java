package org.cd.weioa.entity;

/**
 * Created by xuyang on 16/5/10.
 */
public enum FeedBackAttrType {

    WORK(0), FINANCE(1);

    private int value;
    private FeedBackAttrType(int type)
    {
        this.value = type;
    }

    public int getValue()
    {
        return value;
    }

    public static FeedBackAttrType valueOf(int valueInt)
    {
        for(FeedBackAttrType type : FeedBackAttrType.values())
        {
            if(type.value == valueInt)
                return type;
        }

        return null;
    }
}

package org.cd.weioa.http;

import org.apache.log4j.Logger;
import com.google.gson.Gson;
import org.apache.http.impl.client.HttpClients;
import java.io.IOException;
import java.util.Map;
import org.apache.http.HttpEntity;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.util.EntityUtils;

/**
 * Http连接工具类
 * 
 * @author : liuyk
 */
public class HttpHelper {

    private static Logger logger = Logger.getLogger(HttpHelper.class);

    private static CloseableHttpClient httpClient;

    private httpContext context;

    // 最大连接数
    private static final int maxTotalConn = 1000;

    // 单路由最大连接数
    private static final int maxPerRoute = 50;

    static {
        // 创建http连接池管理
        PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager();
        // 设置最大连接数据 所有路由连接数之和 默认为20
        cm.setMaxTotal(maxTotalConn);
        // 设置每个路由上的基础连接数 默认为2
        cm.setDefaultMaxPerRoute(maxPerRoute);
        httpClient = HttpClients.custom().setConnectionManager(cm).build();
    }

    public static HttpHelper getInstance() {
        return new HttpHelper(new httpContext());
    }

    private HttpHelper(httpContext context) {
        this.context = context;
    }

    public HttpHelper setUrl(String url) {
        this.context.setUrl(url);
        return this;
    }

    /**
     * @author : liuyk
     * @param name 参数名称
     * @param value 参数值
     */
    public HttpHelper setParam(String name, String value) {
        this.context.setParam(name, value);
        return this;
    }

    /**
     * 批量设置参数
     *
     * @author : liuyk
     * @param params 批量参数集合
     */
    public HttpHelper setParam(Map<String, String> params) {
        this.context.setParam(params);
        return this;
    }

    public HttpHelper setHeader(String key, String value) {
        this.context.setHeader(key, value);
        return this;
    }

    public String post() {
        String content = null;
        CloseableHttpResponse response = null;
        try {
            HttpPost post = new HttpPost(this.context.url);
            // 设置用户自定义header
            this.context.setHandlerHeader(post);
            if (this.context.params.size() != 0) {
                post.setEntity(new UrlEncodedFormEntity(this.context.params));
            }
            response = httpClient.execute(post);
            logger.debug("DefaultHttpHandler excute httpost begin - url:" + this.context.url + " -  params:" + new Gson().toJson(this.context.params));
            HttpEntity entity = response.getEntity();
            content = EntityUtils.toString(entity);
            // 关闭底层资源
            logger.debug("DefaultHttpHandler excute httpost end - result:" + content);
            EntityUtils.consume(entity);
        } catch (ClientProtocolException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } catch (ParseException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } catch (IOException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } finally {
            this.close(response);
        }
        return content;
    }

    public String get() {
        String content = null;
        CloseableHttpResponse response = null;
        try {
            HttpGet get = new HttpGet(this.context.urlAppendParam());
            // 设置用户自定义header
            this.context.setHandlerHeader(get);
            response = httpClient.execute(get);
            logger.debug("DefaultHttpHandler excute httpost begin - url:" + this.context.url + " - params:" + new Gson().toJson(this.context.params));
            HttpEntity entity = response.getEntity();
            content = EntityUtils.toString(entity);
            // 关闭底层资源
            logger.debug("DefaultHttpHandler excute httpost end - result:" + content);
            EntityUtils.consume(entity);
        } catch (ClientProtocolException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } catch (ParseException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } catch (IOException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } finally {
            this.close(response);
        }
        return content;
    }

    public String put() {
        String content = null;
        CloseableHttpResponse response = null;
        try {
            HttpPut put = new HttpPut(this.context.url);
            this.context.setHandlerHeader(put);
            if (this.context.params.size() != 0) {
                put.setEntity(new UrlEncodedFormEntity(this.context.params));
            }
            response = httpClient.execute(put);
            logger.debug("DefaultHttpHandler excute httpost begin - url:" + context.url + " - params:" + new Gson().toJson(context.params));
            HttpEntity entity = response.getEntity();
            content = EntityUtils.toString(entity);
            logger.debug("DefaultHttpHandler excute httpost end - result:" + content);
            EntityUtils.consume(entity);
        } catch (ClientProtocolException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } catch (ParseException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } catch (IOException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } finally {
            this.close(response);
        }
        return content;
    }

    public String post(String body) {
        String content = null;
        CloseableHttpResponse response = null;
        try {
            HttpPost post = new HttpPost(this.context.urlAppendParam());
            this.context.setHandlerHeader(post);
            if (body != null) {
                post.setEntity(new ByteArrayEntity(body.getBytes("UTF-8")));
            }
            response = httpClient.execute(post);
            logger.debug("DefaultHttpHandler excute httpost begin - url:" + context.url + " - params:" + new Gson().toJson(this.context.params));
            HttpEntity entity = response.getEntity();
            content = EntityUtils.toString(entity);
            // 关闭底层资源
            logger.debug("DefaultHttpHandler excute httpost end - result:" + content);
            EntityUtils.consume(entity);
        } catch (ClientProtocolException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } catch (ParseException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } catch (IOException e) {
            logger.error("DefaultHttpHandler excute httpost error - :", e);
        } finally {
            this.close(response);
        }
        return content;
    }

    public String delete() {
        String content = null;
        CloseableHttpResponse response = null;
        try {
            HttpDelete delete = new HttpDelete(this.context.urlAppendParam());
            response = httpClient.execute(delete);
            logger.debug("DefaultHttpHandler excute httpdelete begin - url:" + context.url + " - params:" + new Gson().toJson(this.context.params));
            HttpEntity entity = response.getEntity();
            content = EntityUtils.toString(entity);
            logger.debug("DefaultHttpHandler excute httpdelete end - result:" + content);
            EntityUtils.consume(entity);
        } catch (ClientProtocolException e) {
            logger.error("DefaultHttpHandler excute httpdelete error - :", e);
        } catch (ParseException e) {
            logger.error("DefaultHttpHandler excute httpdelete error - :", e);
        } catch (IOException e) {
            logger.error("DefaultHttpHandler excute httpdelete error - :", e);
        } finally {
            this.close(response);
        }
        return content;
    }

    public void close(CloseableHttpResponse response) {
        if (response != null) {
            try {
                response.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

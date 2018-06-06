package com.wondersgroup.operation.util.file;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.w3c.dom.Document;

import com.wondersgroup.framework.util.FileUploadUtils;
import com.wondersgroup.framework.util.FoodConstant;
import com.wondersgroup.util.TimeOrDateUtils;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRResultSetDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanArrayDataSource;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapArrayDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import net.sf.jasperreports.engine.data.JRXmlDataSource;

/**
 *
 * @author wanglei
 *
 */
public abstract class ReportProcessor {

    public static enum TYPE {

        XLS, XLSX, PDF, HTML
    }

    /**
     * create report and export with http response
     *
     * @param type
     * @param req
     * @param resp
     * @param jaspers
     * @param dataSources
     * @param outputFileName
     * @param otherParameters
     * @throws Exception
     */
    public void processWebReport(TYPE type, HttpServletRequest req, HttpServletResponse resp, List<File> jaspers,
            List<Object> dataSources, String outputFileName, Object otherParameters) throws Exception {
        List<Object> reportDataSources = ReportProcessor.createReportDataSource(dataSources);

        if (reportDataSources != null && !reportDataSources.isEmpty()) {
            try {
                List<JasperPrint> prints = this.fillData(req, resp, jaspers, reportDataSources,
                        outputFileName, otherParameters);

                if (prints != null && resp != null) {
                    this.exportWebReport(type, prints, resp, outputFileName, otherParameters);
                }
            } catch (Exception e) {
                throw e;
            } finally {
                if (!reportDataSources.isEmpty()) {
                    try {
                        for (Object reportDataSource : reportDataSources) {
                            if (reportDataSource instanceof Connection) {
                                ((Connection) reportDataSource).close();
                            } else if (reportDataSource instanceof ResultSet) {
                                ((ResultSet) reportDataSource).close();
                            }
                        }
                    } catch (SQLException e) {
                        throw e;
                    }
                }
            }
        }
    }

    /**
     * create report and export to local path
     *
     * @param type
     * @param req
     * @param resp
     * @param jaspers
     * @param dataSources
     * @param fileOutputStream
     * @param outputFileName
     * @param otherParameters
     * @throws Exception
     */
    public void processLocalReport(TYPE type, HttpServletRequest req, HttpServletResponse resp, List<File> jaspers,
            List<Object> dataSources, FileOutputStream fileOutputStream, String outputFileName, Object otherParameters) throws Exception {
        List<Object> reportDataSources = ReportProcessor.createReportDataSource(dataSources);

        if (reportDataSources != null && !reportDataSources.isEmpty()) {
            try {
                List<JasperPrint> prints = this.fillData(req, resp, jaspers, reportDataSources,
                        outputFileName, otherParameters);

                if (prints != null) {
                    this.exportLocalReport(type, prints, fileOutputStream, outputFileName, otherParameters);
                }
            } catch (Exception e) {
                throw e;
            } finally {
                if (!reportDataSources.isEmpty()) {
                    try {
                        for (Object reportDataSource : reportDataSources) {
                            if (reportDataSource instanceof Connection) {
                                ((Connection) reportDataSource).close();
                            } else if (reportDataSource instanceof ResultSet) {
                                ((ResultSet) reportDataSource).close();
                            }
                        }
                    } catch (SQLException e) {
                        throw e;
                    }
                }
            }
        }
    }

    /**
     * create report datasource, accept DataSource, Connection, ResultSet,
     * JRDataSource, Collection<Map>, Collection[Bean], XML Document, Map[],
     * Bean[]
     *
     * @param dataSources
     * @return
     * @throws Exception
     */
    public static List<Object> createReportDataSource(List<Object> dataSources) throws Exception {
        List<Object> returnValues = new ArrayList<Object>();

        if (dataSources != null && !dataSources.isEmpty()) {
            for (Object dataSource : dataSources) {
                boolean useConnDataSource = false;
                Connection connection = null;
                JRDataSource jrDataSource = null;
                if (dataSource instanceof DataSource) {
                    useConnDataSource = true;
                    connection = ((DataSource) dataSource).getConnection();
                } else if (dataSource instanceof Connection) {
                    useConnDataSource = true;
                    connection = (Connection) dataSource;
                } else if (dataSource instanceof ResultSet) {
                    ResultSet resultSet = (ResultSet) dataSource;
                    jrDataSource = new JRResultSetDataSource(resultSet);
                } else if (dataSource instanceof JRDataSource) {
                    jrDataSource = (JRDataSource) dataSource;
                } else if (dataSource instanceof Collection) {
                    Collection collection = (Collection) dataSource;
                    if (collection.size() > 0) {
                        Object entry0 = collection.iterator().next();
                        if (entry0 instanceof Map) {
                            jrDataSource = new JRMapCollectionDataSource((Collection<Map<String, ?>>) collection);
                        } else {
                            jrDataSource = new JRBeanCollectionDataSource(collection);
                        }
                    } else {
                        jrDataSource = new JREmptyDataSource();
                    }
                } else if (dataSource instanceof Document) {
                    Document document = (Document) dataSource;
                    jrDataSource = new JRXmlDataSource(document);
                } else if (dataSource instanceof Object[]) {
                    Object[] objs = (Object[]) dataSource;
                    if (objs.length > 0) {
                        Object obj0 = objs[0];
                        if (obj0 instanceof Map) {
                            jrDataSource = new JRMapArrayDataSource(objs);
                        } else {
                            jrDataSource = new JRBeanArrayDataSource(objs);
                        }
                    } else {
                        jrDataSource = new JREmptyDataSource();
                    }
                }

                if (useConnDataSource && connection != null) {
                    returnValues.add(connection);
                } else {
                    returnValues.add(jrDataSource);
                }
            }
        }
        return returnValues;
    }

    /**
     *
     * @param req
     * @param resp
     * @param jaspers
     * @param dataSources
     * @param outputFileName
     * @param otherParameters
     * @return
     * @throws Exception
     */
    public abstract List<JasperPrint> fillData(HttpServletRequest req, HttpServletResponse resp, List<File> jaspers,
            List<Object> dataSources, String outputFileName, Object otherParameters) throws Exception;

    /**
     * export report with http response
     *
     * @param type
     * @param prints
     * @param resp
     * @param outputFileName
     * @param otherParameters
     * @throws Exception
     */
    public abstract void exportWebReport(TYPE type, List<JasperPrint> prints,
            HttpServletResponse resp, String outputFileName, Object otherParameters) throws Exception;

    /**
     * export report to local path
     *
     * @param type
     * @param prints
     * @param fileOutputStream
     * @param outputFileName
     * @param otherParameters
     * @throws Exception
     */
    public abstract void exportLocalReport(TYPE type, List<JasperPrint> prints,
            FileOutputStream fileOutputStream, String outputFileName, Object otherParameters) throws Exception;

    /**
     *
     * @param filename
     * @return
     */
    protected String getFileNameNoEx(String filename) {
        if ((filename != null) && (filename.length() > 0)) {
            int dot = filename.lastIndexOf('.');
            if ((dot > -1) && (dot < (filename.length()))) {
                return filename.substring(0, dot);
            }
        }
        return filename;
    }

    /**
     * 生成报表后返回本地文件下载路径
     * @param dataSourceList
     * @param jasperFileNameList
     * @return
     * @throws Exception 
     */
    public String processExcelReport(List<Object> dataSourceList, List<String> jasperFileNameList) throws Exception{
        //加载jasper模板文件
        if(jasperFileNameList==null || jasperFileNameList.isEmpty()){
            return null;
        }
        List<File> files = new ArrayList<>();
        for(String jasperFileName : jasperFileNameList){
            File jasperFile = new File(FileUploadUtils.contextPath + "/jasper/" + jasperFileName);
            files.add(jasperFile);
        }
        //生成数据源
        List<Object> reportDataSource = createReportDataSource(dataSourceList);
        //生成文件名
        Random r = new Random();
        int tmp = Math.abs(r.nextInt() % 1000000);
        String folderName = TimeOrDateUtils.formateDate(new Date(), "yyyy_MM_dd");
        String fileName = TimeOrDateUtils.formateDate(new Date(), "yyyy_MM_dd_HH_mm_ss")+"_"+tmp;
        String uploadPath = FileUploadUtils.contextPath + FileUploadUtils.upload;
        String localPath = uploadPath + "/" + FoodConstant.ATT_DOWNLOAD_TEMP + "/" + folderName;
        //生成文件夹
        File folder = new File(localPath);
        if (!folder.exists()){
            folder.mkdirs();
        }
        String excelFilePath = localPath + "/" + fileName + ".xlsx";
        File excelFile = new File(excelFilePath);
        //生成excel文件
        this.processLocalReport(ReportProcessor.TYPE.XLSX, null, null, files, reportDataSource, new FileOutputStream(excelFile), fileName+".xlsx", null);
        //打包成zip
        /*
        String zipFilePath = localPath + "/" + fileName + ".zip";
        File zipFile = new File(zipFilePath);
        BufferedInputStream bis = null;
        ZipOutputStream zos = null;
        try {
            bis = new BufferedInputStream(new FileInputStream(excelFile));
            zos = new ZipOutputStream(new FileOutputStream(zipFile));
            ZipEntry entry = new ZipEntry(excelFile.getName());  
            zos.putNextEntry(entry);  
            int len;  
            byte data[] = new byte[1024];  
            while ((len = bis.read(data))>0) {  
                zos.write(data, 0, len);  
            }
        } catch (IOException e) {
            throw e;
        } finally {
            try {
                if(zos!=null) {
                    zos.flush();
                    zos.close();
                }
            } catch (IOException e) {
            }
            try {
                if(bis!=null) {
                    bis.close();
                }
            } catch (IOException e) {
            }
        }
        File transferFile = zipFile;
        */
        String downloadPath = FileUploadUtils.upload + "/" + FoodConstant.ATT_DOWNLOAD_TEMP + "/" + folderName + "/" + fileName + ".xlsx";
        return downloadPath;
    }
    
}

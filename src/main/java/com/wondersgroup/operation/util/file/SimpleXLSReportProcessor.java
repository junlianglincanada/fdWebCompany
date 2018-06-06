package com.wondersgroup.operation.util.file;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.export.AbstractXlsReportConfiguration;
import net.sf.jasperreports.export.Exporter;
import net.sf.jasperreports.export.ExporterInput;
import net.sf.jasperreports.export.ExporterInputItem;
import net.sf.jasperreports.export.ExporterOutput;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleExporterInputItem;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;

/**
 *
 * @author wanglei
 *
 */
public class SimpleXLSReportProcessor extends ReportProcessor {

    /**
     * sheet name parameter's key name in otherParameters, if you want to
     * specify sheet names, parameter's value can be a List or String array.
     */
    public static final String XLS_SHEET_NAMES = "excel_report_sheet_names_key";
    /**
     * sheet use parameter list key name in otherParameters, if you want to
     * specify each sheet's parameters, parameter's value can be a List.
     */
    public static final String XLS_SHEET_PARAMETERS = "excel_report_sheet_parameters_key";

    @SuppressWarnings({"unchecked", "rawtypes"})
    @Override
    public List<JasperPrint> fillData(HttpServletRequest req,
            HttpServletResponse resp, List<File> jaspers, List<Object> dataSources,
            String outputFileName, Object otherParameters) throws Exception {
        List<JasperPrint> prints = null;
        if (jaspers != null && !jaspers.isEmpty() && dataSources != null && !dataSources.isEmpty()) {
            Map<String, Object> paras = new HashMap<String, Object>();
            List<Map<String, Object>> reportParas = null;
            Map<String, Object> defaultReportParas = null;
            if (otherParameters != null && (otherParameters instanceof Map)) {
                paras = (Map<String, Object>) otherParameters;
                if (paras.containsKey(XLS_SHEET_PARAMETERS)) {
                    Object object = paras.get(XLS_SHEET_PARAMETERS);
                    if (object != null && (object instanceof Map)) {
                        defaultReportParas = (Map<String, Object>) object;
                    } else if (object != null && (object instanceof List)) {
                        reportParas = (List) object;
                    }
                } else {
                    defaultReportParas = paras;
                }
            }

            prints = new ArrayList<>();
            int i = 0;
            Object dataSource = null;
            for (File jasperFile : jaspers) {
                JasperReport report = (JasperReport) JRLoader.loadObject(jasperFile);
                JasperPrint jasperPrint = null;

                Map<String, Object> useReportParas = null;
                if (reportParas != null && !reportParas.isEmpty() && reportParas.size() > i) {
                    useReportParas = reportParas.get(i);
                } else {
                    useReportParas = defaultReportParas;
                }

                if (dataSources.size() > i) {
                    dataSource = dataSources.get(i);
                }

                if (dataSource != null && (dataSource instanceof Connection)) {
                    jasperPrint = JasperFillManager.fillReport(report, useReportParas, (Connection) dataSource);
                } else if (dataSource != null && (dataSource instanceof JRDataSource)) {
                    jasperPrint = JasperFillManager.fillReport(report, useReportParas, (JRDataSource) dataSource);
                }
                if (jasperPrint != null) {
                    prints.add(jasperPrint);
                }
                i++;
            }
        }
        return prints;
    }

    @Override
    public void exportWebReport(TYPE type, List<JasperPrint> prints,
            HttpServletResponse resp, String outputFileName,
            Object otherParameters) throws Exception {
        if (prints != null && prints.size() > 0 && resp != null) {
            resp.reset();
            if (type != null && type.equals(ReportProcessor.TYPE.XLSX)) {
                resp.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            } else {
                resp.setContentType("application/vnd.ms-excel");
            }
            //解决中文文件名
            if (outputFileName != null && !outputFileName.isEmpty()) {
                resp.setHeader("charset", "ISO8859-1");
                resp.setHeader("Content-Disposition", "attachment;filename=\"" + new String(outputFileName.getBytes(), "ISO8859-1") + "\"");
            }
            BufferedOutputStream outputStream = null;
            try {
                outputStream = new BufferedOutputStream(resp.getOutputStream());
                String[] sheetNames = null;
                if (otherParameters != null && (otherParameters instanceof Map)) {
                    Map<String, Object> paras = (Map<String, Object>) otherParameters;

                    if (paras.containsKey(XLS_SHEET_NAMES)) {
                        Object namesObj = paras.get(XLS_SHEET_NAMES);
                        if (namesObj != null) {
                            sheetNames = this.filterSheetNames(prints.size(), namesObj);
                        }
                    }
                }

                this.exportExcelReport(type, prints, outputStream, outputFileName, sheetNames);

            } catch (Exception e) {
                throw e;
            } finally {
                if (outputStream != null) {
                    outputStream.flush();
                    outputStream.close();
                }
            }
        }
    }

    @Override
    public void exportLocalReport(TYPE type, List<JasperPrint> prints, FileOutputStream fileOutputStream,
            String outputFileName, Object otherParameters) throws Exception {
        if (prints != null && prints.size() > 0 && fileOutputStream != null) {
            BufferedOutputStream outputStream = null;
            try {
                outputStream = new BufferedOutputStream(fileOutputStream);
                String[] sheetNames = null;
                if (otherParameters != null && (otherParameters instanceof Map)) {
                    Map<String, Object> paras = (Map<String, Object>) otherParameters;

                    if (paras.containsKey(XLS_SHEET_NAMES)) {
                        Object namesObj = paras.get(XLS_SHEET_NAMES);
                        if (namesObj != null) {
                            sheetNames = this.filterSheetNames(prints.size(), namesObj);
                        }
                    }
                }

                this.exportExcelReport(type, prints, outputStream, outputFileName, sheetNames);

            } catch (Exception e) {
                throw e;
            } finally {
                if (outputStream != null) {
                    outputStream.flush();
                    outputStream.close();
                }
            }
        }
    }

    /**
     * rename repeat sheet names or add missing sheet names
     *
     * @param printNum
     * @param nameObjs
     * @return
     */
    @SuppressWarnings("rawtypes")
    protected String[] filterSheetNames(int printNum, Object nameObjs) {
        String[] names = null;
        List<String> sheetNameList = new ArrayList<String>();
        int rptNum = 0;
        if (nameObjs != null && (nameObjs instanceof List)) {
            List list = (List) nameObjs;
            for (int i = 0; i < printNum; i++) {
                String tmpName = null;
                if (list.size() > i && list.get(i) != null) {
                    tmpName = list.get(i).toString();
                    while (sheetNameList.contains(tmpName)) {
                        tmpName += "_rpt";
                    }
                } else {
                    tmpName = "Sheet" + (rptNum++);
                    while (sheetNameList.contains(tmpName)) {
                        tmpName = "Sheet" + (rptNum++);
                    }
                }
                sheetNameList.add(tmpName);
            }
        } else if (nameObjs != null && (nameObjs instanceof String[])) {
            String[] ss = (String[]) nameObjs;
            for (int i = 0; i < printNum; i++) {
                String tmpName = null;
                if (ss.length > i && ss[i] != null) {
                    tmpName = ss[i];
                    while (sheetNameList.contains(tmpName)) {
                        tmpName += "_rpt";
                    }
                } else {
                    tmpName = "Sheet" + (rptNum++);
                    while (sheetNameList.contains(tmpName)) {
                        tmpName = "Sheet" + (rptNum++);
                    }
                }
            }
        }

        if (sheetNameList.size() > 0) {
            names = new String[sheetNameList.size()];
            for (int j = 0; j < sheetNameList.size(); j++) {
                String sheetName = sheetNameList.get(j);
                sheetName = sheetName.replaceAll("[&\\*\\[\\]\\\\:\"'\\?/<>]", " ");
                names[j] = sheetName;
            }
        }

        return names;
    }

    /**
     *
     * @param type
     * @param prints
     * @param outputStream
     * @param filename
     * @param sheetNames
     * @throws net.sf.jasperreports.engine.JRException
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public void exportExcelReport(TYPE type, List<JasperPrint> prints, OutputStream outputStream,
            String filename, String[] sheetNames) throws JRException {
        Exporter exporter = null;
        if (type != null && type.equals(TYPE.XLSX)) {
            exporter = new JRXlsxExporter();
        } else {
            exporter = new JRXlsExporter();
        }
        
        AbstractXlsReportConfiguration reportConfiguration = new AbstractXlsReportConfiguration();
        reportConfiguration.setDetectCellType(Boolean.TRUE);
        reportConfiguration.setCollapseRowSpan(Boolean.TRUE);
        reportConfiguration.setRemoveEmptySpaceBetweenRows(Boolean.TRUE);
        reportConfiguration.setOnePagePerSheet(Boolean.FALSE);
        reportConfiguration.setWhitePageBackground(Boolean.FALSE);
        //reportConfiguration.setMaxRowsPerSheet(Integer.MAX_VALUE);
        //reportConfiguration.setFontSizeFixEnabled(Boolean.TRUE);
        if (sheetNames != null && sheetNames.length > 0) {
            reportConfiguration.setSheetNames(sheetNames);
        }
        
        List<ExporterInputItem> inputItems = new ArrayList<ExporterInputItem>();
        if(prints!=null){
            for(JasperPrint print : prints){
                inputItems.add(new SimpleExporterInputItem(print));
            }
        }
        ExporterInput exporterInput = new SimpleExporterInput(inputItems);
        ExporterOutput exporterOutput = new SimpleOutputStreamExporterOutput(outputStream);
        
        exporter.setConfiguration(reportConfiguration);
        exporter.setExporterInput(exporterInput);
        exporter.setExporterOutput(exporterOutput);

        /*
        exporter.setParameter(JRExporterParameter.JASPER_PRINT_LIST, prints);
        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
        exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
        exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN, Boolean.TRUE);
        exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE); // 删除记录下面的空行
        exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
        exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
	//exporter.setParameter(JRXlsExporterParameter.MAXIMUM_ROWS_PER_SHEET, Integer.MAX_VALUE);
        //exporter.setParameter(JRXlsExporterParameter.IS_FONT_SIZE_FIX_ENABLED, Boolean.TRUE);
        if (filename != null && !filename.isEmpty()) {
            exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, filename);
        }
        if (sheetNames != null && sheetNames.length > 0) {
            exporter.setParameter(JRXlsExporterParameter.SHEET_NAMES, sheetNames);
        }
        */
        exporter.exportReport();
    }
}

package com.chcit.scm.web.ent.action;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.Joinable;

import net.sf.jasperreports.components.barbecue.BarbecueCompiler;
import net.sf.jasperreports.components.barbecue.BarcodeProviders.NW7Provider;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;

import com.chcit.base.web.json.JsonResultException;
import com.chcit.base.web.json.ProcessResult;
import com.chcit.base.web.util.QueryResult;
import com.chcit.scm.eai.model.MBPartner;
import com.chcit.scm.eai.model.MBPartnerContact;
import com.chcit.scm.eai.model.MBPartnerLocation;
import com.chcit.scm.eai.model.MBPartnerSaleArea;
import com.chcit.scm.eai.model.MEmployee;
import com.chcit.scm.eai.model.MProduct;
import com.chcit.scm.eai.model.MProductPO;
import com.chcit.scm.eai.util.LinkUtil;
import com.chcit.scm.edi.service.EDIService;
import com.chcit.scm.web.ent.action.bean.BPartnerFavoriteFolderQueryBean;
import com.chcit.scm.web.ent.action.bean.BPartnerQueryBean;
import com.chcit.scm.web.ent.action.bean.ProductQueryBean;
import com.scopetec.ad.model.MServer;
import com.scopetec.base.bo.client.ServiceManager;
import com.scopetec.base.data.DataResultSet;
import com.scopetec.base.util.StringUtil;
import com.scopetec.util.Ctx;
import com.scopetec.util.DB;
import com.scopetec.util.Env;

@Controller("bPartnerAction")
public class BPartnerActionController extends BaseActionController {
	private static final Log log = LogFactory
			.getLog(StorageActionController.class);

	public void querySelfResp(HttpServletRequest req, HttpServletResponse resp,
			BPartnerQueryBean paramBean) {
		/*String isCustomer=req.getParameter("customer");
		if(isCustomer!=null&&isCustomer.length()>0){
			paramBean.setCustomer(isCustomer);
		}*/
		paramBean.setEmployeeID(""+Ctx.currentCtx().getContext("#EAI_Employee_ID"));
		query(req,resp,paramBean);
	}
	
	
	public void queryBPartner(HttpServletRequest req,HttpServletResponse resp,BPartnerQueryBean paramBean){
		query(req,resp,paramBean);
	}
	
	public void query(HttpServletRequest req, HttpServletResponse resp,
			BPartnerQueryBean paramBean) {
		try {
			QueryResult result = query(paramBean);
			JSONArray rows = new JSONArray();
			DataResultSet rs = result.rs;
			while (rs.next()) {
				JSONObject jsonData = new JSONObject();
				jsonData.element("Name", rs.getString("Name"));
				jsonData.element("EAI_BPartner_ID", rs
						.getLong("EAI_BPartner_ID"));
				jsonData.element("Value", rs.getString("Value"));
				jsonData.element("AD_Server_ID", rs.getString("AD_Server_ID"));
				jsonData
						.element("CustomerLevel", rs.getString("CustomerLevel"));
				jsonData.element("CustomerLevelName", rs
						.getString("CustomerLevelName"));
				// jsonData.element("BPartnerProperty", rs
				// .getString("BPartnerProperty"));
				// jsonData.element("Position", rs.getString("Position"));
				jsonData.element("IsCustomer", rs.getString("IsCustomer"));
				jsonData.element("IsVendor", rs.getString("IsVendor"));
				jsonData.element("Address", rs.getString("Address"));
				jsonData.element("Phone", rs.getString("Phone"));
				// jsonData.element("LicenseType", rs.getString("LicenseType"));
				// jsonData.element("LicenseNo", rs.getString("LicenseNo"));
				// jsonData.element("HasGMPCert", rs.getString("HasGMPCert"));
				// jsonData.element("HasGSPCert", rs.getString("HasGSPCert"));
				jsonData.element("LegalPerson", rs.getString("LegalPerson"));
				jsonData.element("CorpFund", rs.getString("CorpFund"));
				jsonData
						.element("BusinessScope", rs.getString("BusinessScope"));

				jsonData.element("Contact", rs.getString("Contact"));
				jsonData.element("ContactPhone", rs.getString("ContactPhone"));
				jsonData.element("ContactIDNo", rs.getString("ContactIDNo"));
				jsonData.element("Contact2", rs.getString("Contact2"));
				jsonData
						.element("ContactPhone2", rs.getString("ContactPhone2"));
				jsonData.element("ContactIDNo2", rs.getString("ContactIDNo2"));
				// jsonData.element("IsApproved", rs.getString("IsApproved"));
				// jsonData.element("ApproveUser", rs.getString("ApproveUser"));
				// jsonData.element("ApproveTime",
				// DateUtil.toString(rs.getTimestamp
				// ("ApproveTime"),"yyyy-MM-dd"));

				jsonData.element("BPartnerCode", rs.getString("BPartnerCode"));
				jsonData.element("Description", rs.getString("Description"));
				// jsonData.element("IsActive", rs.getString("IsActive"));
				jsonData.element("IsStop", rs.getString("IsStop"));
				jsonData.element("IsQaStop", rs.getString("IsQaStop"));
				jsonData.element("ContactCount", rs.getInt("ContactCount"));
				jsonData.element("Purchaser_ID", rs.getInt("Purchaser_ID"));
				
				
				String areaText=MBPartnerSaleArea.getAllSaleArea(rs.getInt("EAI_BPartner_ID"));
				if(areaText!=null&&areaText.length()>0){
					jsonData.element("SaleAreaName", areaText);
				}

				rows.add(jsonData);
			}
			JSONObject json = new JSONObject();
			json.element("total", result.total);
			json.element("rows", rows);
			sendJSON(resp, json.toString());

		} catch (Exception e) {
			e.printStackTrace();
			ProcessResult<JSON> pr = new ProcessResult<JSON>(false);
			pr.setMessage(e.getMessage() != null ? e.getMessage() : e
					.toString());
			sendJSON(resp, pr.toJSON());

		}

	}

	private QueryResult query(BPartnerQueryBean paramBean) throws Exception {
		// int C_BPartner_ID=
		// Ctx.currentCtx().getContextAsInt("#C_BPartner_ID");
		// int EAI_BPartner_ID = getEAI_BPartner_ID();
		// String userType = Ctx.currentCtx().getContext("#UserType");
		ArrayList<Object> params = new ArrayList<Object>();
		ArrayList<Object> countparams = new ArrayList<Object>();
		StringBuffer where = new StringBuffer();
		// if ("customer".equalsIgnoreCase(userType)){
		// where.append(" AND o.AD_Org_ID=?");
		// params.add(Ctx.currentCtx().getAD_Org_ID());
		// countparams.add(Ctx.currentCtx().getAD_Org_ID());
		// }
		// else
		// if ("vendor".equalsIgnoreCase(userType)){
		// where.append(" AND EAI_BPartner_ID=?");
		// params.add(getEAI_BPartner_ID());
		// countparams.add(getEAI_BPartner_ID());
		// }
		/*StringBuffer countsql = new StringBuffer(
				"SELECT COUNT(1) FROM EAI_BPARTNER_V eb " +
				(null != paramBean.getProductID()?"INNER JOIN eai_product_po ep on(eb.eai_bpartner_id=ep.eai_bpartner_id and ep.eai_product_id=?)":"")
				+" left join EAI_BPartner_Contact c ON (eb.EAI_BPartner_ID=c.EAI_BPartner_ID) "	
		        +"WHERE 1=1 ");*/
		StringBuffer sql = new StringBuffer(
				"SELECT eb.name,eb.EAI_BPartner_ID,eb.AD_Server_ID,eb.value,eb.Address ,eb.Phone,eb.customerlevel,eb.CustomerLevelName,"
						+ "eb.ContactPhone ,eb.Contact, eb.ContactIDNo,eb.ContactPhone2 ,eb.Contact2, eb.ContactIDNo2,"
						+ "eb.LegalPerson,eb.CorpFund,eb.BusinessScope,eb.iscustomer,eb.isvendor,eb.isstop,eb.isqastop,"
						+ "eb.Description,eb.BPartnerCode,count(c.EAI_BPartner_Contact_ID) ContactCount,eb.Purchaser_ID  "
						+ "FROM EAI_BPARTNER_V eb " +
						(null != paramBean.getProductID()?"INNER JOIN eai_product_po ep on(eb.eai_bpartner_id=ep.eai_bpartner_id and ep.eai_product_id=?)":"")
						+" left join EAI_BPartner_Contact c ON (eb.EAI_BPartner_ID=c.EAI_BPartner_ID) "
						+" left join EAI_Employee e ON (eb.Purchaser_ID=e.EAI_Employee_ID) "
						+" WHERE 1=1 ");
		if(!StringUtils.isEmpty(paramBean.getProductID())){
			params.add(paramBean.getProductID());
			countparams.add(paramBean.getProductID());
		}
		where.append(" and eb.IsActive='Y'");
		if (!StringUtils.isEmpty(paramBean.getName())) {
			if(StringUtil.isChinese(paramBean.getName())){
				where.append(" AND eb.Name Like ?");
				params.add(getLikeValue(paramBean.getName()));
				countparams.add(getLikeValue(paramBean.getName()));
		   }else{
			    where.append(" AND (Upper(Value) Like ? OR BpartnerCode Like ?) ");
			    params.add(getLikeValue(paramBean.getName().toUpperCase()));
				countparams.add(getLikeValue(paramBean.getName().toUpperCase()));
				params.add(getLikeValue(paramBean.getName()));
				countparams.add(getLikeValue(paramBean.getName()));
		   }
		}
		if (!StringUtils.isEmpty(paramBean.getValue())) {
			where.append(" AND UPPER(Value) like UPPER(?)");
			params.add(getLikeValue(paramBean.getValue()));
			countparams.add(getLikeValue(paramBean.getValue()));
		}
		if (!StringUtils.isEmpty(paramBean.getBpartnerCode())) {
			where.append(" AND eb.BPartnerCode like ?");
			params.add(getLikeValue(paramBean.getBpartnerCode()));
			countparams.add(getLikeValue(paramBean.getBpartnerCode()));
		}
		
		if (!StringUtils.isEmpty(paramBean.getBpartnerID())) {
			where.append(" AND eb.EAI_BPartner_ID=?");
			params.add(paramBean.getBpartnerID());
			countparams.add(paramBean.getBpartnerID());
		}
		// 有"客户级别"时,要求isCustomer值为"Y"
		if (!StringUtils.isEmpty(paramBean.getCustomerLevel())) {
			where.append(" AND eb.CustomerLevel=?");
			paramBean.setCustomer("Y");
			params.add(paramBean.getCustomerLevel());
			countparams.add(paramBean.getCustomerLevel());
		}
		if ("Y".equalsIgnoreCase(paramBean.getSelfOrg())) {
			// int AD_Server_ID = getAD_Server_ID();
			where
					.append(" AND EXISTS (SELECT 1 FROM EAI_Org_BPartner sp WHERE sp.EAI_BPartner_ID=eb.EAI_BPartner_ID AND "
							+ "sp.IsActive='Y' AND sp.AD_Org_ID = ?");
			params.add(Ctx.currentCtx().getAD_Org_ID());
			countparams.add(Ctx.currentCtx().getAD_Org_ID());
			// 客户、供应商查询条件按机构客商表为准
			if (paramBean.getCustomer() != null
					&& paramBean.getCustomer().length() > 0) {
				where.append(" AND sp.IsCustomer=?");
				params.add("Y".equalsIgnoreCase(paramBean.getCustomer()) ? "Y"
						: "N");
				countparams
						.add("Y".equalsIgnoreCase(paramBean.getCustomer()) ? "Y"
								: "N");
			}
			if (paramBean.getVendor() != null
					&& paramBean.getVendor().length() > 0) {
				where.append(" AND sp.IsVendor=?");
				params.add("Y".equalsIgnoreCase(paramBean.getVendor()) ? "Y"
						: "N");
				countparams
						.add("Y".equalsIgnoreCase(paramBean.getVendor()) ? "Y"
								: "N");
			}
			where.append(")");
		} else if ("N".equalsIgnoreCase(paramBean.getSelfOrg())) {
			// int AD_Server_ID = getAD_Server_ID();
			where
					.append(" AND NOT EXISTS (SELECT 1 FROM EAI_Org_BPartner sp WHERE sp.EAI_BPartner_ID=eb.EAI_BPartner_ID AND "
							+ "sp.IsActive='Y' AND sp.AD_Org_ID = ?)");
			params.add(Ctx.currentCtx().getAD_Org_ID());
			countparams.add(Ctx.currentCtx().getAD_Org_ID());
			if (paramBean.getCustomer() != null
					&& paramBean.getCustomer().length() > 0) {
				where.append(" AND eb.IsCustomer=?");
				params.add("Y".equalsIgnoreCase(paramBean.getCustomer()) ? "Y"
						: "N");
				countparams
						.add("Y".equalsIgnoreCase(paramBean.getCustomer()) ? "Y"
								: "N");
			}
			if (paramBean.getVendor() != null
					&& paramBean.getVendor().length() > 0) {
				where.append(" AND eb.IsVendor=?");
				params.add("Y".equalsIgnoreCase(paramBean.getVendor()) ? "Y"
						: "N");
				countparams
						.add("Y".equalsIgnoreCase(paramBean.getVendor()) ? "Y"
								: "N");
			}
		} else {
			if (paramBean.getCustomer() != null
					&& paramBean.getCustomer().length() > 0) {
				where.append(" AND eb.IsCustomer=?");
				params.add("Y".equalsIgnoreCase(paramBean.getCustomer()) ? "Y"
						: "N");
				countparams
						.add("Y".equalsIgnoreCase(paramBean.getCustomer()) ? "Y"
								: "N");
			}
			if (paramBean.getVendor() != null
					&& paramBean.getVendor().length() > 0) {
				where.append(" AND eb.IsVendor=?");
				params.add("Y".equalsIgnoreCase(paramBean.getVendor()) ? "Y"
						: "N");
				countparams
						.add("Y".equalsIgnoreCase(paramBean.getVendor()) ? "Y"
								: "N");
			}
		}
		if (paramBean.getActive() != null && paramBean.getActive().length() > 0) {
			where.append(" AND eb.IsActive=?");
			params.add("Y".equalsIgnoreCase(paramBean.getActive()) ? "Y" : "N");
			countparams.add("Y".equalsIgnoreCase(paramBean.getActive()) ? "Y"
					: "N");
		}
		/*if (paramBean.getEmployeeID()!=null&&paramBean.getEmployeeID().length()>0){
			where.append(" AND eb.EAI_BPartner_ID IN (SELECT EAI_BPartner_ID FROM EAI_BPartner_Employee be WHERE be.EAI_Employee_ID=? AND be.IsActive='Y')");
			params.add(paramBean.getEmployeeID());
			countparams.add(paramBean.getEmployeeID());
		}*/
		
		//增加有部门访问权限的客商
		if (paramBean.getEmployeeID()!=null&&paramBean.getEmployeeID().length()>0){
			where.append(" AND eb.EAI_BPartner_ID IN ((SELECT EAI_BPartner_ID FROM EAI_BPartner_Employee be  INNER JOIN EAI_Employee e on (be.EAI_EMPLOYEE_ID=e.EAI_EMPLOYEE_ID)"+
                         " WHERE e.AD_Department_ID in (SELECT AD_Department_ID FROM EAI_Employee_Dept_Access A where a.EAI_Employee_ID=? and a.isActive='Y'))" +
                         " UNION ALL ( SELECT EAI_BPartner_ID FROM eai_bpartner_employee be where be.EAI_EMPLOYEE_ID=?))");
			
			params.add(paramBean.getEmployeeID());
			params.add(paramBean.getEmployeeID());
			countparams.add(paramBean.getEmployeeID());
			countparams.add(paramBean.getEmployeeID());
		}
		
		
		if (paramBean.getValidation()!=null&&paramBean.getValidation().length()>0){
			where.append(" AND ").append(paramBean.getValidation());
		}
		String qaStop = paramBean.getQaStop();
		String stop = paramBean.getStop();
		if (StringUtils.isNotEmpty(qaStop)) {
			where.append(" and eb.IsQAStop=?");
			params.add("Y".equalsIgnoreCase(qaStop) ? "Y" : "N");
			countparams.add("Y".equalsIgnoreCase(qaStop) ? "Y" : "N");
		}
		if (StringUtils.isNotEmpty(stop)) {
			where.append(" and eb.IsStop=?");
			params.add("Y".equalsIgnoreCase(stop) ? "Y" : "N");
			countparams.add("Y".equalsIgnoreCase(stop) ? "Y" : "N");
		}
		
		if (paramBean.getAd_Server_ID()>0&&paramBean.getAd_Server_ID()!=getAD_Server_ID()){
			where.append(" AND eb.AD_Server_ID = ?"); //在集团的商品目录内
			params.add(paramBean.getAd_Server_ID());
			countparams.add(paramBean.getAd_Server_ID());
		}
		else {
			where.append(" AND eb.AD_Server_ID = ? AND eb.AD_Org_ID IN (0,?)"); 
			params.add(getAD_Server_ID());
			countparams.add(getAD_Server_ID());
			params.add(Ctx.currentCtx().getAD_Org_ID());
			countparams.add(Ctx.currentCtx().getAD_Org_ID());
		}
		
		
		where.append(" GROUP BY  eb.name,eb.EAI_BPartner_ID,eb.AD_Server_ID,eb.value,eb.Address ,eb.Phone,eb.customerlevel,eb.CustomerLevelName,"
						+ "eb.ContactPhone ,eb.Contact, eb.ContactIDNo,eb.ContactPhone2 ,eb.Contact2, eb.ContactIDNo2,"
						+ "eb.LegalPerson,eb.CorpFund,eb.BusinessScope,eb.iscustomer,eb.isvendor,eb.isstop,eb.isqastop,"
						+ "eb.Description,eb.BPartnerCode,eb.Purchaser_ID,e.EAI_Employee_ID ");
		
		if (paramBean.getSort() != null && paramBean.getSort().length() > 0) {
			where.append(" ORDER BY "
					+ paramBean.getSort()
					+ " "
					+ (StringUtils.isNotEmpty(paramBean.getDir()) ? paramBean
							.getDir() : ""));
		} else
			where.append(" ORDER BY eb.Name");
		// System.out.println(where);
		
		
		
		//String countsqlstr = countsql.append(where).toString();
		String sqlstr = sql.append(where).toString();
		// if (!"vendor".equalsIgnoreCase(userType)){
		// }
		String countsql="SELECT COUNT(*) FROM ("+sqlstr+")";
		countsql = DB.addAccessSQL(countsql, "", true, false, true);
		sqlstr = DB.addAccessSQL(sqlstr, "", true, false, true);
		int total = DB.getSQLValue(countsql, countparams.toArray());
		DataResultSet rs = DB.executePageQuery(sqlstr, paramBean.getStart(),
				paramBean.getLimit(), params.toArray());
		return new QueryResult(rs, total);
	}

	// 保存和修改客商信息
	public void saveAndEdit(HttpServletRequest req, HttpServletResponse resp)
			throws JsonResultException {
		try {
			String id = req.getParameter("id");
			// 同一站点的客商编码不能重复
			String BPartnerCode = req.getParameter("BPartnerCode");
			MBPartner bp = null;
			if (StringUtils.isNotEmpty(id))
				bp = MBPartner.get(Integer.valueOf(id));
			if (bp == null) {
				bp = new MBPartner();
				bp.setIsActive(true);
				bp.setSource_Server_ID(LinkUtil.getSelfServerID());
				bp.setAD_Server_ID(getAD_Server_ID());
				if (bp.getAD_Server_ID()==0)
					throw new Exception("缺少当前站点");
				MServer srv = MServer.get(bp.getAD_Server_ID());
				if (srv==null)
					throw new Exception("站点"+bp.getAD_Server_ID()+"未找到");
				bp.setClientOrg(srv);
				
			}
			// else {
			// if (bp.getAD_OrgBP_ID() != ctx.getAD_Org_ID())
			// throw new Exception("只能更新本机构的客商信息");
			// }

//			String AD_Server_ID = req.getParameter("AD_Server_ID");
//			int serverId;
//			try {
//				serverId = Integer.valueOf(AD_Server_ID);
//			} catch (Exception e) {
//				throw new Exception("请选择合适的站点");
//			}

			boolean exists = false;
			String sql = "SELECT EAI_BPartner_ID FROM eai_bpartner where AD_Server_ID=? and BPartnerCode=?";
			DataResultSet rs = DB.executeQuery(sql,bp.getAD_Server_ID(),BPartnerCode);
			if (StringUtils.isEmpty(id)) {
				if (rs.count() > 0)
					exists = true;
			} else {
				if (rs.count() == 0
						|| (rs.count() == 1 && rs.getInt(1) == Integer
								.valueOf(id)))
					exists = false;
				else {
					exists = true;
				}
			}
			if (exists)
				throw new Exception("客商编码重复");

			bp.setBPartnerCode(BPartnerCode);
			bp.setName(req.getParameter("Name"));
			bp.setValue(req.getParameter("Value"));
			bp.setAddress(req.getParameter("Address"));
			bp.setPhone(req.getParameter("Phone"));
			bp.setLegalPerson(req.getParameter("LegalPerson"));
			String CorpFund = req.getParameter("CorpFund");
			if (CorpFund != null && CorpFund.trim().length() > 0)
				try {
					bp.setCorpFund(new BigDecimal(CorpFund.trim()));
				} catch (NumberFormatException e) {
					throw new Exception("注册资金格式错误");
				}
			else
				bp.setCorpFund(Env.ZERO);
			// System.out.println("req.getParameter('CustomerLevel')="+req.
			// getParameter("CustomerLevel"));
			String customerLevel = req.getParameter("CustomerLevel");
			if (StringUtils.isNotEmpty(customerLevel))
				bp.setCustomerLevel(customerLevel);
			bp.setBusinessScope(req.getParameter("BusinessScope"));
			bp.setContact(req.getParameter("Contact"));
			bp.setContactPhone(req.getParameter("ContactPhone"));
			bp.setContactIDNo(req.getParameter("ContactIDNo"));
			bp.setContact2(req.getParameter("Contact2"));
			bp.setContactPhone2(req.getParameter("ContactPhone2"));
			bp.setContactIDNo2(req.getParameter("ContactIDNo2"));
			bp.setDescription(req.getParameter("Description"));
			// System.out.println("req.getParameter('IsCustomer')="+req.
			// getParameter("IsCustomer"));
			//System.out.println("req.getParameter('IsVendor')="+req.getParameter
			// ("IsVendor"));
			bp.setIsCustomer("on".equalsIgnoreCase(req
					.getParameter("IsCustomer")));
			bp.setIsVendor("on".equalsIgnoreCase(req.getParameter("IsVendor")));
			bp.save();
		} catch (Exception e) {
			e.printStackTrace();
			throw new JsonResultException(e);
		}
		ProcessResult<JSON> pr = new ProcessResult<JSON>(true);
		sendJSON(resp, pr.toJSON());

	}

	// 删除单个记录
	public void delete(HttpServletRequest req, HttpServletResponse resp)
			throws JsonResultException {
		try {
			String id = req.getParameter("EAI_BPartner_ID");
			MBPartner bp = null;
			if (StringUtils.isNotEmpty(id)) {
				bp = MBPartner.get(Integer.valueOf(id));
			}
			if (bp != null) {
				bp.setIsActive(false);// 逻辑删除
				bp.save();
			}
			ProcessResult<JSON> pr = new ProcessResult<JSON>(true);
			sendJSON(resp, pr.toJSON());
		} catch (Exception e) {
			e.printStackTrace();
			throw new JsonResultException(e);
		}
	}

	/**
	 * 质量停用/恢复 操作
	 * 
	 * @param req
	 * @param resp
	 * @throws JsonResultException
	 */
	public void qastopChange(HttpServletRequest req, HttpServletResponse resp)
			throws JsonResultException {
		try {
			String id = req.getParameter("id");
			String change = req.getParameter("change");
			MBPartner bp = MBPartner.get(Integer.parseInt(id));
			ProcessResult<JSON> pr = new ProcessResult<JSON>(true);
			if (bp != null) {
				if ("Y".equalsIgnoreCase(change)) {
					if (bp.isQAStop())
						throw new JsonResultException("该客商已经处于质量停用状态！");
					else {
						bp.setIsQAStop(true);
						bp.save();
					}
					pr.setMessage("客商已成功质量停用");
				} else if ("N".equalsIgnoreCase(change)) {
					if (!bp.isQAStop())
						throw new JsonResultException("该客商不是质量停用状态！");
					else {
						bp.setIsQAStop(false);
						bp.save();
					}
					pr.setMessage("客商已成功质量恢复");
				}
			} else {
				throw new JsonResultException("该客商不存在");
			}

			sendJSON(resp, pr.toJSON());
		} catch (Exception e) {
			e.printStackTrace();
			throw new JsonResultException(e);
		}
	}

	/**
	 * 停用/恢复 操作
	 * 
	 * @param req
	 * @param resp
	 * @throws JsonResultException
	 */
	public void stopChange(HttpServletRequest req, HttpServletResponse resp)
			throws JsonResultException {
		try {
			String id = req.getParameter("id");
			String change = req.getParameter("change");
			MBPartner bp = MBPartner.get(Integer.parseInt(id));
			ProcessResult<JSON> pr = new ProcessResult<JSON>(true);
			if (bp != null) {
				if ("Y".equalsIgnoreCase(change)) {
					if (bp.isStop())
						throw new JsonResultException("该客商已经处于停用状态！");
					else {
						bp.setIsStop(true);
						bp.save();
					}
					pr.setMessage("客商已成功停用");
				} else if ("N".equalsIgnoreCase(change)) {
					if (!bp.isStop())
						throw new JsonResultException("该客商不是停用状态！");
					else {
						bp.setIsStop(false);
						bp.save();
					}
					pr.setMessage("客商已成功恢复");
				}
			} else {
				throw new JsonResultException("该客商不存在");
			}

			sendJSON(resp, pr.toJSON());
		} catch (Exception e) {
			e.printStackTrace();
			throw new JsonResultException(e);
		}
	}
//
//	// 测试 自动完成
//	public void auto(HttpServletRequest req, HttpServletResponse resp,
//			RefListBean paramBean) {
//		try {
//			QueryResult result = auto(paramBean);
//			JSONArray rows = new JSONArray();
//			DataResultSet rs = result.rs;
//			while (rs.next()) {
//				JSONObject jsonData = new JSONObject();
//				jsonData.element("name", rs.getString("Name"));
//				jsonData.element("id", rs.getLong("EAI_BPartner_ID"));
//				rows.add(jsonData);
//			}
//			JSONObject json = new JSONObject();
//			json.element("total", result.total);
//			json.element("rows", rows);
//			sendJSON(resp, json.toString());
//		} catch (Exception e) {
//			e.printStackTrace();
//			ProcessResult<JSON> pr = new ProcessResult<JSON>(false);
//			pr.setMessage(e.getMessage() != null ? e.getMessage() : e
//					.toString());
//			sendJSON(resp, pr.toJSON());
//		}
//	}
//
//	private QueryResult auto(RefListBean paramBean) throws Exception {
//		ArrayList<Object> params = new ArrayList<Object>();
//		ArrayList<Object> countparams = new ArrayList<Object>();
//		StringBuffer where = new StringBuffer();
//		String query = paramBean.getQuery();
//		String str = query == null ? "" : query.trim();
//		String defaultValue = paramBean.getDefaultValue();
//		String dValue = defaultValue == null ? "" : defaultValue.trim();
//		StringBuffer countsql = new StringBuffer(
//				"SELECT COUNT(1) FROM EAI_BPARTNER_V  WHERE 1=1");
//		StringBuffer sql = new StringBuffer(
//				"SELECT name,EAI_BPartner_ID FROM EAI_BPARTNER_V WHERE 1=1");
//		if(StringUtils.isNotEmpty(dValue)){
//			where.append(" AND EAI_BPARTNER_ID = ?");
//			params.add(dValue);
//			countparams.add(dValue);
//		}
//		else if (StringUtils.isNotEmpty(str)) {
//			where.append(" AND (Name like ? or UPPER(Value) like UPPER(?))");
//			params.add(getLikeValue(str));
//			countparams.add(getLikeValue(str));
//			params.add(str + "%");
//			countparams.add(str + "%");
//		}
//		where.append(" and isactive='Y'");
//		if (paramBean.getSort() != null && paramBean.getSort().length() > 0) {
//			where.append(" ORDER BY "
//					+ (paramBean.getSort().equals("id")?"EAI_BPartner_ID":paramBean.getSort())
//					+ " "
//					+ (StringUtils.isNotEmpty(paramBean.getDir()) ? paramBean
//							.getDir() : ""));
//		} else
//			where.append(" ORDER BY Name");
//		String countsqlstr = countsql.append(where).toString();
//		String sqlstr = sql.append(where).toString();
//		countsqlstr = DB.addAccessSQL(countsqlstr, "", true, false, true);
//		sqlstr = DB.addAccessSQL(sqlstr, "", true, false, true);
//		int total = DB.getSQLValue(countsqlstr, countparams.toArray());
//		DataResultSet rs = DB.executePageQuery(sqlstr, paramBean.getStart(),
//				paramBean.getLimit(), params.toArray());
//		return new QueryResult(rs, total);
//	}

	// public void approve(HttpServletRequest req, HttpServletResponse resp) {
	// try {
	// String id = req.getParameter("id");
	// String approveUser = req.getParameter("approveUser");
	// String approveTime = req.getParameter("approveTime");
	//			
	// MBPartner bp = MBPartner.get(Integer.parseInt(id));
	// bp.setIsApproved(true);
	// bp.setApproveUser(approveUser);
	// bp.setApproveTime(DateUtil.toTimestamp(DateUtil.toDate(approveTime,
	// "yyyy-MM-dd")));
	// bp.save();
	// ProcessResult<JSON> pr = new ProcessResult<JSON>(true);
	// sendJSON(resp, pr.toJSON());
	// } catch (Exception e) {
	// e.printStackTrace();
	// ProcessResult<JSON> pr = new ProcessResult<JSON>(false);
	// pr.setMessage(e.getMessage() != null ? e.getMessage() : e
	// .toString());
	// sendJSON(resp, pr.toJSON());
	//			
	// }
	//		
	// }
	
	
	/**
	 * 客商导入
	 */
	public void importBPartner(HttpServletRequest req,
			HttpServletResponse resp) throws IOException {
		
		InputStream in = null;
		try {
			int AD_Org_ID = Integer.valueOf(req.getParameter("AD_Org_ID"));
			int AD_Server_ID=getAD_Server_ID();

			String filekey = req.getParameter("filekey");
			
			int  ediFormatId=DB.getSQLValue("SELECT f.EDI_Format_ID FROM EDI_Format f join EDI_DOC d on (d.EDI_Doc_ID=f.EDI_Doc_ID) WHERE  f.IsActive='Y' AND d.Value='BPartner' AND f.AD_Server_ID=?",
					AD_Server_ID);

			if(ediFormatId==0){
				 throw new Exception("请先设置导入格式");
			}
			if (StringUtils.isEmpty(filekey))
				throw new Exception("缺少导入文件");

			
			MultipartFile uploadfile = ((DefaultMultipartHttpServletRequest) req)
					.getFile(filekey);
			String orginalFilename = uploadfile.getOriginalFilename();

			in = uploadfile.getInputStream();
            int row=ServiceManager.getService(EDIService.class).importBPartner(in, AD_Server_ID, AD_Org_ID, ediFormatId, true);
			StringBuffer log = new StringBuffer("成功导入"+row+"个客商明细");
			log.append("!");

			//System.out.println("count:=" + count);
			ProcessResult<JSON> pr = new ProcessResult<JSON>(true);
			pr.setMessage(log.toString());
			JSONObject jsonResult = new JSONObject();
			jsonResult.element("fileName", orginalFilename);
			pr.setData(jsonResult);
			sendJSON(resp, pr.toJSON());

		} catch (Exception e) {
			e.printStackTrace();
			throw new JsonResultException(e);
		} finally {
			if (in != null)
				in.close();
		}
	}
	
	
	
	public void getBPartnerContact(HttpServletRequest request,HttpServletResponse response,BPartnerQueryBean paramBean){
		 
		try{
		 	
		  MEmployee employee=null;	
		  MBPartner bPartner=null;
		  if(paramBean.getBpartnerID()!=null&&paramBean.getBpartnerID().length()>0){
			  bPartner=MBPartner.get(Integer.valueOf(paramBean.getBpartnerID()));
			  if(bPartner!=null){
				  if(bPartner.getPurchaser_ID()>0){
				   employee=MEmployee.get(bPartner.getPurchaser_ID());
				  
				  }
			  }
		  }
			
		  StringBuffer sql=new StringBuffer(" SELECT c.EAI_BPartner_Contact_ID,c.EAI_Bpartner_ID,c.Name,c.Phone," +
		  		" c.Email,c.Phone2,c.Fax," +
		  		" b.Name BPartnerName,b.BPartnerCode ,b.Address, "+
		  		" b.Purchaser_ID  "+
				  " FROM EAI_BPartner_Contact c " );
		  sql.append(" INNER JOIN EAI_Bpartner b ON (c.EAI_Bpartner_ID=b.EAI_Bpartner_ID) ");
		  
		  StringBuffer where =new StringBuffer();
		  where.append(" WHERE c.IsActive='Y' ");
		  
		  ArrayList<Object>params=new ArrayList<Object>();
		  
		  if (paramBean.getBpartnerID()!=null && paramBean.getBpartnerID().length()>0){
				where.append(" AND c.EAI_BPartner_ID=?");
				params.add(paramBean.getBpartnerID());
			}
		   sql.append(where);
		  
		   if (paramBean.getSort()!=null && paramBean.getSort().length()>0){
				sql.append(" ORDER BY " + paramBean.getSort());
				if (paramBean.getDir()!=null && paramBean.getDir().length()>0)
					sql.append(" ").append(paramBean.getDir());
			}
		   
		   String sqlStr = DB.addAccessSQL(sql.toString(), "", true, false);
		   String countsql="SELECT COUNT(1) FROM ("+sqlStr+")";
		   int total=DB.getSQLValue(countsql, params.toArray());
		   DataResultSet rs=DB.executePageQuery(sqlStr,paramBean.getStart(),paramBean.getLimit(), params.toArray());	  
		
		   JSONArray rows=new JSONArray();
		   
		    if(total<=0){
		    if(employee!=null){
		    	 JSONObject json=new JSONObject();
		    	  json.element("BPartnerName", bPartner.getName());
				   json.element("BPartnerCode", bPartner.getBPartnerCode());
				   json.element("Address", bPartner.getAddress());
				   json.element("Purchaser_ID", employee.getEAI_Employee_ID());
				   json.element("PurchaserName", employee.getName());
				   json.element("PurchaserPhone", employee.getPhone());
				   json.element("PurchaserMobile", employee.getMobile());
				   json.element("PurchaserEmail", employee.getEMail());
				   total=1;
				   rows.add(json);
				   }
		    }else{
		   while(rs.next()){
			   JSONObject json=new JSONObject();
			   json.element("EAI_Bpartner_Contact_ID", rs.getInt("EAI_Bpartner_Contact_ID"));
			   json.element("EAI_Bpartner_ID", rs.getInt("EAI_Bpartner_ID"));
			   json.element("Name", rs.getString("Name"));
			   json.element("Phone", rs.getString("Phone"));
			   json.element("Phone2", rs.getString("Phone2"));
			   json.element("Email", rs.getString("Email"));
			   json.element("Fax", rs.getString("Fax"));
			   json.element("BPartnerName", rs.getString("BPartnerName"));
			   json.element("BPartnerCode", rs.getString("BPartnerCode"));
			   json.element("Address", rs.getString("Address"));
			   if(employee!=null){
			    	 
					   json.element("Purchaser_ID", employee.getEAI_Employee_ID());
					   json.element("PurchaserName", employee.getName());
					   json.element("PurchaserPhone", employee.getPhone());
					   json.element("PurchaserMobile", employee.getMobile());
					   json.element("PurchaserEmail", employee.getEMail());
					   
					   }
			   rows.add(json);
		   }
		    }
		   JSONObject object = new JSONObject();
		   object.element("total", total);
		   object.element("rows", rows);
			sendJSON(response, object.toString());
		}
		catch (Exception e) {
			e.printStackTrace();
			ProcessResult<JSON> pr = new ProcessResult<JSON>(false);
			pr.setMessage(e.getMessage()!=null?e.getMessage():e.toString());
			sendJSON(response, pr.toJSON());
		}
	}
	
	
	public void getBPartnerContactByProduct(HttpServletRequest request,HttpServletResponse response){
		 
		try{
		 	
		  String productID=	request.getParameter("productID");
		  int EAI_Product_ID=0;
		  if(productID!=null&&productID.length()>0){
			  EAI_Product_ID=Integer.valueOf(productID);
		  }
		  
		  int AD_Org_ID=Ctx.currentCtx().getAD_Org_ID();
		  
		//  MProduct product=MProduct.get(EAI_Product_ID);
		  
		  MProductPO[] po=MProductPO.getProductPOByProduct(EAI_Product_ID, AD_Org_ID);
			
		  JSONArray bpartners=new JSONArray();
		  
		  for(int i=0;i<po.length;i++){
			  
			  JSONObject bpartner=new JSONObject();
			  
			  
			  MBPartner bPartner=MBPartner.get(po[i].getEAI_BPartner_ID());
			  
			  if(bPartner==null){
				  throw new Exception("客商不存在:"+po[i].getEAI_BPartner_ID());
			  }
			  
			 
			  
			  MBPartnerContact[] bPartnerContact =MBPartnerContact.get(bPartner.getEAI_BPartner_ID(), AD_Org_ID);
		      
			  JSONArray array=new JSONArray();
			  for(int j=0;j<bPartnerContact.length;j++){
				  JSONObject json=new JSONObject();
				  json.element("EAI_BPartner_Contact_ID",bPartnerContact[j].getEAI_BPartner_Contact_ID());
			      json.element("Name", bPartnerContact[j].getName());
			     
			      if(bPartnerContact[j].getPhone()!=null){
			      json.element("Phone", bPartnerContact[j].getPhone());
			      }else{
			    	 if(bPartnerContact[j].getPhone2()!=null){
			    		 json.element("Phone", bPartnerContact[j].getPhone2());
			    		 
			    	 }
			      }
			      array.add(json);
			  }
			  
			  if(array.size()>0){
				bpartner.element("BPartnerName", bPartner.getName());
			    bpartner.element("contacts", array);
			  }
			  
			  if(bpartner.size()>0){
			     bpartners.add(bpartner);
			  }
			  
		  }
		  
		   JSONObject object=new JSONObject();
		   object.element("total", bpartners.size());
		    object.element("rows", bpartners);
			sendJSON(response, object.toString());
		}
		catch (Exception e) {
			e.printStackTrace();
			ProcessResult<JSON> pr = new ProcessResult<JSON>(false);
			pr.setMessage(e.getMessage()!=null?e.getMessage():e.toString());
			sendJSON(response, pr.toJSON());
		}
	}
	

	
	
	public void queryFavoriteFolder(HttpServletRequest req, HttpServletResponse resp,
			BPartnerFavoriteFolderQueryBean paramBean) {
		try {
			QueryResult result = queryFavoriteFolder(paramBean);
			JSONArray rows = new JSONArray();
			DataResultSet rs = result.rs;
			while (rs.next()) {
				JSONObject jsonData = new JSONObject();
				jsonData.element("Name", rs.getString("Name"));
				jsonData.element("EAI_BPartner_ID", rs.getLong("EAI_BPartner_ID"));
				jsonData.element("AD_User_ID", rs.getLong("AD_User_ID"));
				jsonData.element("BPartnerCode", rs.getString("BPartnerCode"));
				jsonData.element("BPartnerName", rs.getString("BPartnerName"));
				jsonData.element("FavoriteFolderName", rs.getString("Name"));
				jsonData.element("EAI_FAVORITEFOLDER_ID", rs.getLong("EAI_FAVORITEFOLDER_ID"));

				rows.add(jsonData);
			}
			JSONObject json = new JSONObject();
			json.element("total", result.total);
			json.element("rows", rows);
			sendJSON(resp, json.toString());

		} catch (Exception e) {
			e.printStackTrace();
			ProcessResult<JSON> pr = new ProcessResult<JSON>(false);
			pr.setMessage(e.getMessage() != null ? e.getMessage() : e
					.toString());
			sendJSON(resp, pr.toJSON());

		}

	}

	private QueryResult queryFavoriteFolder(BPartnerFavoriteFolderQueryBean paramBean) throws Exception {
		
		
		ArrayList<Object> params = new ArrayList<Object>();
		ArrayList<Object> countparams = new ArrayList<Object>();
		StringBuffer where = new StringBuffer();
		
		StringBuffer sql = new StringBuffer(
				"select f.EAI_FAVORITEFOLDER_ID,f.NAME, f.EAI_BPARTNER_ID,f.AD_USER_ID,b.BPARTNERCODE,b.NAME BpartnerName"
                 +" FROM EAI_FavoriteFolder f "
                 +" INNER JOIN EAI_Bpartner_V b on (f.EAI_Bpartner_ID=b.EAI_Bpartner_ID)"
                 +" WHERE f.ISACTIVE='Y'");
		
          String AD_User_ID=Ctx.currentCtx().getContext("#AD_User_ID");
           if(AD_User_ID.length()>0&&AD_User_ID!=null){
        	   where.append(" AND f.AD_User_ID=?");
        	   params.add(Integer.valueOf(AD_User_ID));
           }
                 
                
		if(!StringUtils.isEmpty(paramBean.getBpartnerID())){
			where.append(" AND f.EAI_BPartner_ID=?");
			params.add(paramBean.getBpartnerID());
			
		}
		
		
		if (paramBean.getSort() != null && paramBean.getSort().length() > 0) {
			where.append(" ORDER BY "
					+ paramBean.getSort()
					+ " "
					+ (StringUtils.isNotEmpty(paramBean.getDir()) ? paramBean
							.getDir() : ""));
		} else
			where.append(" ORDER BY f.Name");
		// System.out.println(where);
		
		
		
		//String countsqlstr = countsql.append(where).toString();
		String sqlstr = sql.append(where).toString();
		// if (!"vendor".equalsIgnoreCase(userType)){
		// }
		String countsql="SELECT COUNT(*) FROM ("+sqlstr+")";
		countsql = DB.addAccessSQL(countsql, "", true, false, true);
		sqlstr = DB.addAccessSQL(sqlstr, "", true, false, true);
		int total = DB.getSQLValue(countsql, params.toArray());
		DataResultSet rs = DB.executePageQuery(sqlstr, paramBean.getStart(),
				paramBean.getLimit(), params.toArray());
		return new QueryResult(rs, total);
	}

	
	public void queryBPartnerLocation(HttpServletRequest request,HttpServletResponse response,BPartnerQueryBean bean){
		try{
		String bpartnerID=bean.getBpartnerID();
		if(bpartnerID==null||bpartnerID.length()<=0){
			throw new Exception("缺少客户编码");
		}
		
		MBPartner bPartner=MBPartner.get(Integer.valueOf(bpartnerID));
		if(bPartner==null){
			throw new Exception("客商不存在:"+bpartnerID);
		}
        String sql="SELECT EAI_BPartner_Location_ID,Address,IsDefault, Name From EAI_BPartner_Location l where l.IsActive='Y' AND EAI_BPartner_ID=? Order By IsDefault,Updated Desc ";
        DataResultSet rs=DB.executeQuery(sql,bpartnerID);
        JSONArray array=new JSONArray();
        while(rs.next()){
        	JSONObject json=new JSONObject();
        	json.element("id", rs.getLong("EAI_BPartner_Location_ID"));
        	json.element("address", rs.getString("Name"));
        	json.element("isDefault", rs.getString("IsDefault"));
        	array.add(json);
        }
		JSONObject object=new JSONObject();
		object.element("rows", array);
		sendJSON(response, object.toString());
		}catch (Exception e) {
			e.printStackTrace();
		}
	} 
	
	
	public void queryBPartnerBusinessScope(HttpServletRequest request,HttpServletResponse response,BPartnerQueryBean bean){
		try{
		String bpartnerID=bean.getBpartnerID();
		if(bpartnerID==null||bpartnerID.length()<=0){
			throw new Exception("缺少客户编码");
		}
		
	    int startrow=bean.getStart();
	     int limit= bean.getLimit();
		
		MBPartner bPartner=MBPartner.get(Integer.valueOf(bpartnerID));
		if(bPartner==null){
			throw new Exception("客商不存在:"+bpartnerID);
		}
        String sql="SELECT l.EAI_BPartner_ID,l.EAI_BPartner_BusinessScope_ID,l.BusinessScope,getreflisttrl(1000444,l.BusinessScope)BusinessScopeName From EAI_BPartner_BusinessScope l " +
        		" INNER JOIN EAI_Bpartner b ON (l.EAI_BPartner_ID=b.EAI_BPartner_ID AND b.IsCertJYFW=l.IsCertJYFW ) "+
        " where l.IsActive='Y' AND l.EAI_BPartner_ID=?  ";
        String countsql="SELECT COUNT(1) FROM ("+sql+")";
        DataResultSet rs=DB.executePageQuery(sql, startrow, limit, bpartnerID);
        int total=DB.getSQLValue(countsql,bpartnerID);
        JSONArray array=new JSONArray();
        while(rs.next()){
        	JSONObject json=new JSONObject();
        	json.element("EAI_BPartner_BusinessScope_ID", rs.getLong("EAI_BPartner_BusinessScope_ID"));
        	json.element("BusinessScope", rs.getString("BusinessScope"));
        	json.element("BusinessScopeName", rs.getString("BusinessScopeName"));
        	json.element("EAI_BPartner_ID", rs.getLong("EAI_BPartner_ID"));
        	array.add(json);
        }
		JSONObject object=new JSONObject();
		object.element("rows", array);
		object.element("total", total);
		sendJSON(response, object.toString());
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
	
}

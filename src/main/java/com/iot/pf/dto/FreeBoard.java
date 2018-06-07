package com.iot.pf.dto;


import java.sql.Date;

import org.apache.ibatis.type.Alias;

@Alias("FreeBoard")
public class FreeBoard {
	private int boardNumber;	
	private String userId;
	private String name;
	private	String title;
	private	String content;
	private	Date regDate;
	private	int hits;
	private String hasFile;
	/**
	 * @return the boardNumber
	 */
	public int getBoardNumber() {
		return boardNumber;
	}
	/**
	 * @param boardNumber the boardNumber to set
	 */
	public void setBoardNumber(int boardNumber) {
		this.boardNumber = boardNumber;
	}
	/**
	 * @return the userId
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the title
	 */
	public String getTitle() {
		return title;
	}
	/**
	 * @param title the title to set
	 */
	public void setTitle(String title) {
		this.title = title;
	}
	/**
	 * @return the content
	 */
	public String getContent() {
		return content;
	}
	/**
	 * @param content the content to set
	 */
	public void setContent(String content) {
		this.content = content;
	}
	/**
	 * @return the regDate
	 */
	public Date getRegDate() {
		return regDate;
	}
	/**
	 * @param regDate the regDate to set
	 */
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	/**
	 * @return the hits
	 */
	public int getHits() {
		return hits;
	}
	/**
	 * @param hits the hits to set
	 */
	public void setHits(int hits) {
		this.hits = hits;
	}
	/**
	 * @return the hasFile
	 */
	public String getHasFile() {
		return hasFile;
	}
	/**
	 * @param hasFile the hasFile to set
	 */
	public void setHasFile(String hasFile) {
		this.hasFile = hasFile;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "FreeBoard [boardNumber=" + boardNumber + ", userId=" + userId + ", name=" + name + ", title=" + title
				+ ", content=" + content + ", regDate=" + regDate + ", hits=" + hits + ", hasFile=" + hasFile + "]";
	}

	
	
}
